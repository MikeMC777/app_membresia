module Api
  module V1
    class MembersController < ApiController
      before_action :set_member, only: %i[show update destroy reactivate]
      after_action  :verify_authorized, except: :index
      after_action  :verify_policy_scoped, only: :index

      def index
        authorize Member
        members = policy_scope(Member)
                  .filter_by(index_filter_params)
                  .order(:first_name)

        render json: members,
               each_serializer: MemberSerializer,
               include_team_roles: include_team_roles?
      end


      def show
        authorize @member
        render json: @member
      end

      def create
        @member = Member.new(member_params)
        authorize @member
        if @member.save
          render json: @member, status: :created
        else
          render json: { errors: @member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @member
        if @member.update(member_params)
          render json: @member, status: :ok
        else
          render json: { errors: @member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @member
        @member.destroy
        head :no_content
      end

      def reactivate
        authorize @member, :reactivate?
        if @member.deleted?
          @member.restore(recursive: false)
          render json: @member, status: :ok
        elsif @member.inactive?
          @member.update(status: :active)
          render json: @member, status: :ok
        else
          render json: { error: "Member is already active" }, status: :unprocessable_entity
        end
      end

      private

      def set_member
        @member = action_name == "reactivate" ? Member.with_deleted.find(params[:id]) : Member.find(params[:id])
      end

      def member_params
        params.require(:member).permit(
          :first_name, :second_name, :first_surname, :second_surname,
          :email, :phone, :status, :birth_date, :baptism_date,
          :marital_status, :gender, :wedding_date, :membership_date,
          :address, :city, :state, :country
        )
      end

      def include_team_roles?
        ActiveModel::Type::Boolean.new.cast(params[:include_team_roles])
      end

      # Sólo permitimos los parámetros que el policy deja usar
      def index_filter_params
        allowed = MemberPolicy.new(current_user, Member).allowed_filters
        params.permit(allowed + %i[include_team_roles])
      end
    end
  end
end

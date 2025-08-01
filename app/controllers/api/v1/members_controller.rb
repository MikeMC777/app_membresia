module Api
  module V1
    class MembersController < Api::V1::ApiController
      include Pundit::Authorization
      before_action :set_member, only: %i[show edit update destroy reactivate]

      # GET /members
      def index
        authorize Member
        if params[:status].present?
          @members = policy_scope(Member).where(status: params[:status]).order(:created_at)
        else
          @members = policy_scope(Member).order(:created_at)
        end
      end

      # GET /members/1
      def show
        authorize @member  # Verificación de permisos en 'show'
      end

      # GET /members/new
      def new
        @member = Member.new
        authorize @member  # Verificación de permisos para crear
      end

      # GET /members/1/edit
      def edit
        authorize @member  # Verificación de permisos para crear
      end

      # POST /members
      def create
        @member = Member.new(member_params)
        authorize @member

        if @member.save
          redirect_to @member, notice: "Member was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /members/1
      def update
        authorize @member  # Verificación de permisos para editar
        if @member.update(member_params)
          redirect_to @member, notice: "Member was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /members/1
      def destroy
        authorize @member  # Verificación de permisos para eliminar (soft delete)
        @member.destroy!
        redirect_to members_url, notice: "Member was successfully destroyed.", status: :see_other
      end

      def reactivate
        authorize @member, :reactivate?
        if @member.inactive?
          @member.update(status: :active)
          redirect_to @member, notice: "Member was successfully reactivated."
        else
          redirect_to @member, alert: "Only inactive members can be reactivated."
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_member
          @member = Member.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def member_params
          params.require(:member).permit(:first_name, :second_name, :first_surname, :second_surname, :email, :phone, :status, :birth_date, :baptism_date, :marital_status, :gender, :wedding_date, :membership_date, :address, :city, :state, :country, :deleted_at)
        end
    end
  end
end

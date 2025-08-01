module Api
  module V1
    class PermissionsController < Api::V1::ApiController
      before_action :set_permission, only: %i[ show edit update destroy ]

      # GET /permissions
      def index
        @permissions = Permission.all
      end

      # GET /permissions/1
      def show
      end

      # GET /permissions/new
      def new
        @permission = Permission.new
      end

      # GET /permissions/1/edit
      def edit
      end

      # POST /permissions
      def create
        @permission = Permission.new(permission_params)

        if @permission.save
          redirect_to @permission, notice: "Permission was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /permissions/1
      def update
        if @permission.update(permission_params)
          redirect_to @permission, notice: "Permission was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /permissions/1
      def destroy
        @permission.destroy!
        redirect_to permissions_url, notice: "Permission was successfully destroyed.", status: :see_other
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_permission
          @permission = Permission.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def permission_params
          params.require(:permission).permit(:name, :description, :deleted_at)
        end
    end
  end
end

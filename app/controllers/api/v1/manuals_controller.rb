module Api
  module V1
    class ManualsController < Api::V1::ApiController
      before_action :set_manual, only: %i[ show edit update destroy ]

      # GET /manuals
      def index
        @manuals = Manual.all
      end

      # GET /manuals/1
      def show
      end

      # GET /manuals/new
      def new
        @manual = Manual.new
      end

      # GET /manuals/1/edit
      def edit
      end

      # POST /manuals
      def create
        @manual = Manual.new(manual_params)

        if @manual.save
          redirect_to @manual, notice: "Manual was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /manuals/1
      def update
        if @manual.update(manual_params)
          redirect_to @manual, notice: "Manual was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /manuals/1
      def destroy
        @manual.destroy!
        redirect_to manuals_url, notice: "Manual was successfully destroyed.", status: :see_other
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_manual
          @manual = Manual.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def manual_params
          params.require(:manual).permit(:team_id, :type, :url, :name, :deleted_at)
        end
    end
  end
end

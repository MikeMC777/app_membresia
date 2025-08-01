module Api
  module V1
    class MinutesController < Api::V1::ApiController
      before_action :set_minute, only: %i[ show edit update destroy ]

      # GET /minutes
      def index
        @minutes = Minute.all
      end

      # GET /minutes/1
      def show
      end

      # GET /minutes/new
      def new
        @minute = Minute.new
      end

      # GET /minutes/1/edit
      def edit
      end

      # POST /minutes
      def create
        @minute = Minute.new(minute_params)

        if @minute.save
          redirect_to @minute, notice: "Minute was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /minutes/1
      def update
        if @minute.update(minute_params)
          redirect_to @minute, notice: "Minute was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /minutes/1
      def destroy
        @minute.destroy!
        redirect_to minutes_url, notice: "Minute was successfully destroyed.", status: :see_other
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_minute
          @minute = Minute.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def minute_params
          params.require(:minute).permit(:meeting_id, :title, :agenda, :development, :ending_time, :deleted_at)
        end
    end
  end
end

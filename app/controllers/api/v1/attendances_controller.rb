module Api
  module V1
    class AttendancesController < Api::V1::ApiController
      before_action :set_attendance, only: %i[ show edit update destroy ]

      # GET /attendances
      def index
        @attendances = Attendance.all
      end

      # GET /attendances/1
      def show
      end

      # GET /attendances/new
      def new
        @attendance = Attendance.new
      end

      # GET /attendances/1/edit
      def edit
      end

      # POST /attendances
      def create
        @attendance = Attendance.new(attendance_params)

        if @attendance.save
          redirect_to @attendance, notice: "Attendance was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /attendances/1
      def update
        if @attendance.update(attendance_params)
          redirect_to @attendance, notice: "Attendance was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /attendances/1
      def destroy
        @attendance.destroy!
        redirect_to attendances_url, notice: "Attendance was successfully destroyed.", status: :see_other
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_attendance
          @attendance = Attendance.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def attendance_params
          params.require(:attendance).permit(:member_id, :event_id, :attendance_type, :deleted_at)
        end
    end
  end
end
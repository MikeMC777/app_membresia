class AttendanceConfirmationsController < ApplicationController
  before_action :set_attendance_confirmation, only: %i[ show edit update destroy ]

  # GET /attendance_confirmations
  def index
    @attendance_confirmations = AttendanceConfirmation.all
  end

  # GET /attendance_confirmations/1
  def show
  end

  # GET /attendance_confirmations/new
  def new
    @attendance_confirmation = AttendanceConfirmation.new
  end

  # GET /attendance_confirmations/1/edit
  def edit
  end

  # POST /attendance_confirmations
  def create
    @attendance_confirmation = AttendanceConfirmation.new(attendance_confirmation_params)

    if @attendance_confirmation.save
      redirect_to @attendance_confirmation, notice: "Attendance confirmation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attendance_confirmations/1
  def update
    if @attendance_confirmation.update(attendance_confirmation_params)
      redirect_to @attendance_confirmation, notice: "Attendance confirmation was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /attendance_confirmations/1
  def destroy
    @attendance_confirmation.destroy!
    redirect_to attendance_confirmations_url, notice: "Attendance confirmation was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_confirmation
      @attendance_confirmation = AttendanceConfirmation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_confirmation_params
      params.require(:attendance_confirmation).permit(:member_id, :meeting_id, :confirmed, :attendance_type, :deleted_at)
    end
end

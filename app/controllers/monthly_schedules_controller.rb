class MonthlySchedulesController < ApplicationController
  before_action :set_monthly_schedule, only: %i[ show edit update destroy ]

  # GET /monthly_schedules
  def index
    @monthly_schedules = MonthlySchedule.all
  end

  # GET /monthly_schedules/1
  def show
  end

  # GET /monthly_schedules/new
  def new
    @monthly_schedule = MonthlySchedule.new
  end

  # GET /monthly_schedules/1/edit
  def edit
  end

  # POST /monthly_schedules
  def create
    @monthly_schedule = MonthlySchedule.new(monthly_schedule_params)

    if @monthly_schedule.save
      redirect_to @monthly_schedule, notice: "Monthly schedule was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /monthly_schedules/1
  def update
    if @monthly_schedule.update(monthly_schedule_params)
      redirect_to @monthly_schedule, notice: "Monthly schedule was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /monthly_schedules/1
  def destroy
    @monthly_schedule.destroy!
    redirect_to monthly_schedules_url, notice: "Monthly schedule was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_schedule
      @monthly_schedule = MonthlySchedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def monthly_schedule_params
      params.require(:monthly_schedule).permit(:title, :description, :created_by_id, :scheduled_month, :status, :due_date, :deleted_at)
    end
end

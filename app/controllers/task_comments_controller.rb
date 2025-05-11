class TaskCommentsController < ApplicationController
  before_action :set_task_comment, only: %i[ show edit update destroy ]

  # GET /task_comments
  def index
    @task_comments = TaskComment.all
  end

  # GET /task_comments/1
  def show
  end

  # GET /task_comments/new
  def new
    @task_comment = TaskComment.new
  end

  # GET /task_comments/1/edit
  def edit
  end

  # POST /task_comments
  def create
    @task_comment = TaskComment.new(task_comment_params)

    if @task_comment.save
      redirect_to @task_comment, notice: "Task comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /task_comments/1
  def update
    if @task_comment.update(task_comment_params)
      redirect_to @task_comment, notice: "Task comment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /task_comments/1
  def destroy
    @task_comment.destroy!
    redirect_to task_comments_url, notice: "Task comment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_comment
      @task_comment = TaskComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_comment_params
      params.require(:task_comment).permit(:body, :task_id, :member_id, :deleted_at)
    end
end

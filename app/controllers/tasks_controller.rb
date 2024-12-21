class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy mark_as_completed]

  def index
    @tasks = Task.all
    @pending_tasks = @tasks.where(status: "pending")
    @completed_tasks = @tasks.where(status: "completed")
    @overdue_tasks = @tasks.where(status: "overdue")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  def mark_as_completed
    @task.update(status: "completed")
    redirect_to tasks_path, notice: "Task marked as completed."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status)
  end
end

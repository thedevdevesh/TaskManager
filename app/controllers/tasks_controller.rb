class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy mark_as_completed]

  # Lists all tasks categorized by status
  def index
    @pending_tasks = Task.pending
    @completed_tasks = Task.completed
    @overdue_tasks = Task.overdue
  end

  # Renders the new task form
  def new
    @task = Task.new
  end

  # Creates a new task
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new
    end
  end

  # Renders the edit task form
  def edit; end

  # Updates an existing task
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit
    end
  end

  # Deletes a task
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  # Marks a task as completed
  def mark_as_completed
    if @task.pending? # Ensure only pending tasks can be marked as completed
      @task.update(status: "completed")
      redirect_to tasks_path, notice: "Task marked as completed."
    else
      redirect_to tasks_path, alert: "Only pending tasks can be marked as completed."
    end
  end

  private

  # Sets the task instance for actions requiring a specific task
  def set_task
    @task = Task.find(params[:id])
  end

  # Permitted parameters for task creation and updates
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status)
  end
end

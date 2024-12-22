class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy mark_as_completed]

  # Lists all tasks categorized by status
  def index
    @pending_tasks = Task.pending.order(due_date: :asc)
    @completed_tasks = Task.completed.order(due_date: :desc)
    @overdue_tasks = Task.overdue.order(due_date: :desc)
  end

  # Renders the new task form
  def new
    @task = Task.new
  end

  # Creates a new task
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task created successfully."
      redirect_to tasks_path
    else
      flash.now[:alert] = "There was an error creating the task."
      render :new
    end
  end

  # Renders the edit task form
  def edit; end

  # Updates an existing task
  def update
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully."
      redirect_to tasks_path
    else
      flash[:alert] = "There was an error updating the task."
      render :edit
    end
  end

  # Deletes a task
  def destroy
    @task.destroy
    flash[:notice] = "Task deleted successfully."
    redirect_to tasks_path
  end

  # Marks a task as completed
  def mark_as_completed
    if @task.pending?
      @task.update(status: :completed)
      flash[:notice] = "Task marked as completed."
    else
      flash[:alert] = "Only pending tasks can be marked as completed."
    end
    redirect_to tasks_path
  end

  private

  # Sets the task instance for actions requiring a specific task
  def set_task
    @task = Task.find_by(id: params[:id])
    unless @task
      flash[:alert] = "Task not found."
      redirect_to tasks_path
    end
  end

  # Permitted parameters for task creation and updates
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status)
  end
end

module TasksHelper
  def formatted_due_date(task)
    task.due_date.strftime("%d %b %Y, %I:%M %p")
  end
end

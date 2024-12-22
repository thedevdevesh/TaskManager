class StatusUpdateJob < ApplicationJob
  queue_as :default

  def perform
    # Find tasks that are pending and have a due date that is past the current time
    tasks = Task.where(status: "pending").where("due_date < ?", Time.current)

    # Update the status of each task to 'overdue'
    tasks.each do |task|
      task.update!(status: :overdue)
    end
  end
end

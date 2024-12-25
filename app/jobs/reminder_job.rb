class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    tasks = Task.where(status: "pending", check_remainder: nil).where("due_date <= ?", 30.minutes.from_now)
    tasks.each do |task|
      TaskMailer.reminder_email(task).deliver_later
      task.update!(check_remainder: true)
    end
  end
end

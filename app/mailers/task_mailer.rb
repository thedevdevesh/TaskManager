class TaskMailer < ApplicationMailer
  def reminder_email(task)
    @task = task
    mail(to: "user@example.com", subject: "Task Reminder: " + task.title)
  end
end

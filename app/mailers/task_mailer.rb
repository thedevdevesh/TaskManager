class TaskMailer < ApplicationMailer
  default from: "no-reply@taskmanager.com"

  def reminder_email(task)
    @task = task
    mail(to: "user@example.com", subject: "Reminder: Task Due Soon - #{@task.title}")
  end
end

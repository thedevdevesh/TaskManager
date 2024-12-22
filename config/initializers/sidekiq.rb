require "sidekiq"
require "sidekiq-cron"

# Configure Sidekiq
Sidekiq.configure_server do |config|
  # Setup the cron jobs
  Sidekiq::Cron::Job.load_from_hash({
    "reminder_job_every_minute" => {
      "class" => "ReminderJob",
      "cron" => "* * * * *",  # Run every minute
      "queue" => "default"
    }
  })
end

Sidekiq.configure_client do |config|
  # Optionally configure for the client, if needed
end

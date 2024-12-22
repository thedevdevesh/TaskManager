require "sidekiq"
require "sidekiq-cron"

# Configure Sidekiq
Sidekiq.configure_server do |config|
  # Setup the cron jobs
  Sidekiq::Cron::Job.load_from_hash({
    "reminder_job_every_30_minutes" => {
      "class" => "ReminderJob",
      "cron" => "*/30 * * * *",  # Run every 30 minutes
      "queue" => "default"
    }
  })
end

Sidekiq.configure_server do |config|
  # Load cron jobs
  Sidekiq::Cron::Job.load_from_hash({
    "status_update_job_every_10_minutes" => {
      "class" => "StatusUpdateJob",
      "cron" => "*/10 * * * *",  # Run every 10 minutes
      "queue" => "default"
    }
  })
end

Sidekiq.configure_client do |config|
  # Optionally configure for the client, if needed
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing tasks
Task.destroy_all

# Generate Pending Tasks
5.times do |i|
  Task.create!(
    title: "Pending Task #{i + 1}",
    description: "This is a pending task with due date in the future.",
    due_date: Time.now + (i + 1).hours,
    status: :pending
  )
end

# Generate Completed Tasks
5.times do |i|
  Task.create!(
    title: "Completed Task #{i + 1}",
    description: "This task has been completed.",
    due_date: Time.now - (i + 1).days,
    status: :completed
  )
end

# Generate Overdue Tasks
5.times do |i|
  Task.create!(
    title: "Overdue Task #{i + 1}",
    description: "This task is overdue.",
    due_date: Time.now - (i + 1).hours,
    status: :overdue
  )
end

# Generate Tasks Approaching Deadline (for testing reminders)
3.times do |i|
  Task.create!(
    title: "Approaching Deadline Task #{i + 1}",
    description: "This task is due soon and should trigger a reminder.",
    due_date: Time.now + (30 - (i * 5)).minutes,
    status: :pending
  )
end

puts "Seeding complete! Created #{Task.count} tasks."

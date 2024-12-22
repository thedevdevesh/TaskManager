FactoryBot.define do
  factory :task do
    title { "Test Task" }
    description { "Task description" }
    due_date { 1.day.from_now }
    status { "pending" }
  end
end

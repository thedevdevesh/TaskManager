class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1, overdue: 2 }

  # Validations
  validates :title, presence: true
  validates :due_date, presence: true
end

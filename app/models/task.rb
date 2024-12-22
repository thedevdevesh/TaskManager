class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1, overdue: 2 }

  # Validations
  validates :title, presence: true
  validates :due_date, presence: true

  private

  # Sets the default status for tasks to 'pending' if not already set
  def set_default_status
    self.status ||= :pending
  end
end

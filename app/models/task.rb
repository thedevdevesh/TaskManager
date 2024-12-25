class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1, overdue: 2 }
  before_update :reset_check_remainder, if: :status_changed?

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :due_date, presence: true

  private

  def reset_check_remainder
    self.check_remainder = false if status == "completed"
  end
end

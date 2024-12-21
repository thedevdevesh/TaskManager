class Task < ApplicationRecord
  validates :title, presence: true
  validates :due_date, presence: true
  validates :status, inclusion: { in: %w[pending completed overdue] }

  before_save :set_default_status
  after_save :check_status

  def set_default_status
    self.status ||= "pending"
  end

  def check_status
    self.update(status: "overdue") if due_date.past? && status == "pending"
  end
end

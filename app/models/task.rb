class Task < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :due_date, presence: true
  validates :status, inclusion: { in: %w[pending completed overdue] }

  # Callbacks
  before_save :set_default_status
  before_save :check_status
  after_initialize :set_default_status, if: :new_record?

  # Scopes
  scope :pending, -> { where(status: "pending").order(:due_date) }
  scope :completed, -> { where(status: "completed").order(:updated_at) }
  scope :overdue, -> { where(status: "overdue").order(:due_date) }

  private

  # Sets the default status for tasks to 'pending' if not already set
  def set_default_status
    self.status ||= "pending"
  end

  # Updates the status to 'overdue' if the due date has passed and the task is still pending
  def check_status
    self.status = "overdue" if due_date.present? && due_date.past? && status == "pending"
  end
end

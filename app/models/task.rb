class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1, overdue: 2 }

  # Validations
  validates :title, presence: true
  validates :due_date, presence: true

  # Callbacks
  before_save :check_status
  after_initialize :set_default_status, if: :new_record?

  # Update status dynamically
  def update_status!
    if due_date < Time.current && pending?
      update!(status: :overdue)
    end
  end

  private

  # Sets the default status for tasks to 'pending' if not already set
  def set_default_status
    self.status ||= :pending
  end

  # Updates the status to 'overdue' if the due date has passed and the task is still pending
  def check_status
    self.status = :overdue if due_date.present? && due_date.past? && status == "pending"
  end
end

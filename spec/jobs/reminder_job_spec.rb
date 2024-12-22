require 'rails_helper'

RSpec.describe ReminderJob, type: :job do
  describe '#perform' do
    let!(:task_due_soon) { create(:task, status: :pending, due_date: 25.minutes.from_now) }
    let!(:task_due_later) { create(:task, status: :pending, due_date: 2.hours.from_now) }
    let!(:completed_task) { create(:task, status: :completed, due_date: 25.minutes.from_now) }

    it 'sends reminder emails for pending tasks due within 30 minutes' do
      expect(TaskMailer).to receive(:reminder_email).with(task_due_soon).and_return(double(deliver_later: true))
      expect(TaskMailer).not_to receive(:reminder_email).with(task_due_later)
      expect(TaskMailer).not_to receive(:reminder_email).with(completed_task)

      ReminderJob.new.perform
    end
  end
end

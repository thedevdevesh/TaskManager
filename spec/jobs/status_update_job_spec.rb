require 'rails_helper'

RSpec.describe StatusUpdateJob, type: :job do
  describe '#perform' do
    let!(:overdue_task) { create(:task, status: :pending, due_date: 1.hour.ago) }
    let!(:future_task) { create(:task, status: :pending, due_date: 1.hour.from_now) }
    let!(:completed_task) { create(:task, status: :completed, due_date: 1.hour.ago) }

    it 'updates status to overdue for pending tasks past their due date' do
      expect {
        StatusUpdateJob.new.perform
      }.to change { overdue_task.reload.status }.from('pending').to('overdue')

      expect(future_task.reload.status).to eq('pending')
      expect(completed_task.reload.status).to eq('completed')
    end
  end
end

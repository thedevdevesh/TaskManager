require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  describe "reminder_email" do
    let(:task) { create(:task, title: "Test Task") }
    let(:mail) { TaskMailer.reminder_email(task) }

    it "sends an email to the correct recipient" do
      expect(mail.to).to eq([ "user@example.com" ])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Reminder: Task Due Soon - Test Task")
    end

    it "renders the correct body" do
      expect(mail.body.encoded).to match("Test Task")
    end
  end
end

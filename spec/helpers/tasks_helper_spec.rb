require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TasksHelper. For example:
#
# describe TasksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TasksHelper, type: :helper do
  let(:task) { create(:task, due_date: Time.current + 2.days) }

  describe "#formatted_due_date" do
    it "returns the correct formatted date" do
      formatted_date = helper.formatted_due_date(task)
      expect(formatted_date).to eq(task.due_date.strftime("%d %b %Y, %I:%M %p"))
    end
  end
end

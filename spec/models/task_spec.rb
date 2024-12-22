require 'rails_helper'

RSpec.describe Task, type: :model do
  # Test the enum
  it "has a valid enum for status" do
    expect(Task.statuses).to eq({ "pending" => 0, "completed" => 1, "overdue" => 2 })
  end

  # Test validations
  it "is valid with a title and due date" do
    task = Task.new(title: "Test Task", due_date: 1.day.from_now)
    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = Task.new(due_date: 1.day.from_now)
    expect(task).to_not be_valid
  end

  it "is invalid without a due date" do
    task = Task.new(title: "Test Task")
    expect(task).to_not be_valid
  end

  # Test default status
  it "sets the default status to pending" do
    task = Task.new(title: "Test Task", due_date: 1.day.from_now)
    task.save
    expect(task.status).to eq("pending")
  end

  # Test status enum
  it "can set status to completed" do
    task = Task.new(title: "Test Task", due_date: 1.day.from_now)
    task.status = :completed
    task.save
    expect(task.status).to eq("completed")
  end
end

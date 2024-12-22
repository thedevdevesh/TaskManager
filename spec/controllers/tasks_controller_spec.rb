require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) do
    { title: "Test Task", description: "Test Description", due_date: 1.day.from_now }
  end

  let(:invalid_attributes) do
    { title: nil, description: "Test Description", due_date: 1.day.from_now }
  end

  # Test GET #index
  describe "GET #index" do
    it "assigns tasks categorized by status" do
      pending_task = Task.create!(valid_attributes.merge(status: :pending))
      completed_task = Task.create!(valid_attributes.merge(status: :completed))
      overdue_task = Task.create!(valid_attributes.merge(status: :overdue))

      get :index

      expect(assigns(:pending_tasks)).to include(pending_task)
      expect(assigns(:completed_tasks)).to include(completed_task)
      expect(assigns(:overdue_tasks)).to include(overdue_task)
    end
  end

  # Test GET #new
  describe "GET #new" do
    it "assigns a new task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  # Test POST #create with valid attributes
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new task and redirects to tasks path" do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new task and re-renders the new task form" do
        expect {
          post :create, params: { task: invalid_attributes }
        }.to_not change(Task, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  # Test PATCH #update with valid attributes
  describe "PATCH #update" do
    let(:task) { Task.create!(valid_attributes) }

    context "with valid attributes" do
      it "updates the task and redirects to tasks path" do
        patch :update, params: { id: task.id, task: { title: "Updated Task" } }
        task.reload
        expect(task.title).to eq("Updated Task")
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the task and re-renders the edit task form" do
        patch :update, params: { id: task.id, task: { title: nil } }
        task.reload
        expect(task.title).to_not eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  # Test DELETE #destroy
  describe "DELETE #destroy" do
    let!(:task) { Task.create!(valid_attributes) }

    it "deletes the task and redirects to tasks path" do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
      expect(response).to redirect_to(tasks_path)
    end
  end

  # Test POST #mark_as_completed
  describe "POST #mark_as_completed" do
    let(:task) { Task.create!(valid_attributes) }

    context "when the task is pending" do
      it "marks the task as completed" do
        post :mark_as_completed, params: { id: task.id }
        task.reload
        expect(task.status).to eq("completed")
        expect(flash[:notice]).to eq("Task marked as completed.")
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "when the task is not pending" do
      before { task.update(status: :completed) }

      it "does not mark the task as completed" do
        post :mark_as_completed, params: { id: task.id }
        task.reload
        expect(task.status).to eq("completed")
        expect(flash[:alert]).to eq("Only pending tasks can be marked as completed.")
        expect(response).to redirect_to(tasks_path)
      end
    end
  end
end

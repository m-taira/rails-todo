require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "response status 200 and renders new task link" do
      get tasks_path
      expect(response).to have_http_status 200
      expect(response.body).to include("New Task")
    end
  end

  describe "GET /tasks/:id" do
    let(:task) { create(:task) }

    it "renders a details of a task" do
      get task_path(task)
      expect(response.body).to include("#{task.name}")
      expect(response.body).to include("#{task.done}")
    end
  end

  describe "GET /task/new" do
    it "renders a new task form" do
      get new_task_path
      assert_select("input[name='task[name]']")
    end
  end

  describe "GET /tasks/:id/edit" do
    let(:task) { create(:task) }

    it "shows a details of a task" do
      get task_path(task)

      expect(response.body).to include("#{task.name}")
      expect(response.body).to include("#{task.done}")
    end
  end

  describe "POST /tasks" do
    it "incleaces number of data" do
      expect do
        post tasks_path, params: {task: attributes_for(:task)}
      end.to change{ Task.count }.by(1) 
    end

    it "redirects to '/tasks/:id'" do
      post tasks_path, params: {task: attributes_for(:task)}

      follow_redirect!
      expect(response.body).to include("Task was successfully created.")
    end
  end

  describe "PATCH /task/:id/edit" do
    let(:task) { create(:task) }
    let(:new_name) { "rename test string" }
    let(:new_done) { true }
    
    it "redirects to '/tasks/:id'" do
      patch task_path(task), params: { task: { name: new_name, done: new_done } }
      follow_redirect!
      expect(response.body).to include("#{new_name}")
      expect(response.body).to include("Task was successfully updated.")
    end
  end

  describe "DELETE /tasks/:id" do
    let(:task) { create(:task) }

    it "redirect_to '/tasks'" do
      delete task_path(task)

      follow_redirect!
      expect(response.body).to include("Task was successfully destroyed.")
    end
  end

  describe "PATCH /tasks/:id/done" do
    let(:task) { create(:task, done: false) }
    it "changes 'done' false to true" do
      patch done_task_path(task)

      follow_redirect!
      expect(response.body).to include("Task was successfully done")
    end
  end

end

class TasksController < ApplicationController
  load_and_authorize_resource

  def new
    @task = Task.new

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "tasks_container",
          Tasks::NewTaskComponent.new(task: @task, current_user:)
        )
      end

      format.html do
        render Tasks::NewTaskComponent.new(task: @task, current_user:), layout: false
      end
    end
  end

def create
  @task = current_user.all_accessible_tasks.new(task_params)
  authorize! :create, @task

  if @task.save
    tasks = Task.includes(:list).accessible_by(current_ability).order(updated_at: :desc)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "tasks_view",
          Dashboard::TasksView.new(tasks:, params:)
        )
      end
      format.html { redirect_to tasks_path }
    end
  else
    format.html { redirect_back fallback_location: root_path }
  end
end

  def edit
    render Tasks::EditableTaskComponent.new(task: @task), layout: false
  end

  def show
    render Tasks::TaskComponent.new(task: @task), layout: false
  end

  def update
    if @task.update(task_params)
      Rails.logger.info("Task #{@task.id} updated successfully.")
    else
      Rails.logger.warn("Failed to update Task #{@task.id}.")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          view_context.dom_id(@task),
          Tasks::TaskComponent.new(task: @task)
        )
      end

      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    if @task.destroy
      Rails.logger.info("Task #{@task.id} destroyed successfully.")
    else
      Rails.logger.warn("Failed to destroy Task #{@task.id}.")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(view_context.dom_id(@task))
      end

      format.html do
        redirect_back fallback_location: root_path, notice: "Task deleted successfully."
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :list_id, :completed)
  end

end

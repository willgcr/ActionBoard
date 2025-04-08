class Dashboard::TasksView < ApplicationView
  def initialize(tasks:, params:)
    @tasks = tasks
    @params = params
    super()
  end

  def view_template
    turbo_frame_tag('tasks_view', class: "flex flex-col w-full max-w-2xl gap-6 p-6") do
      div(class: "flex flex-col sm:flex-row sm:justify-between gap-4") do
        h2(class: "text-2xl font-semibold text-gray-800") { "Your Tasks" }

        div(class: "flex flex-col sm:flex-row gap-2 sm:gap-4") do
          form_with(url: user_tasks_path, method: :get, data: { turbo_frame: "tasks_container" }, class: "flex flex-col sm:flex-row gap-2 sm:gap-4") do |f|
            f.select(:status, available_statuses, { selected: selected_status },
              class: "select select-bordered bg-white text-gray-800 border-gray-300 w-full sm:w-auto",
              onchange: "this.form.requestSubmit()")
          end

          link_to("New Task", new_task_path, data: { turbo_frame: "tasks_container" }, class: "btn btn-neutral w-full sm:w-auto")
        end
      end

      turbo_frame_tag "tasks_container" do
        if @tasks.any?
          div(class: "divide-y divide-gray-200 border border-gray-200 rounded-lg overflow-hidden") do
            @tasks.each do |task|
              render Tasks::TaskComponent.new(task: task)
            end
          end
        else
          div(class: "text-center text-gray-500 mt-12") { "You don’t have any tasks yet." }
        end
      end
    end
  end

  private

  attr_reader :tasks, :params

  def available_statuses
    [["All Tasks", ""], ["Pending", "pending"], ["Completed", "completed"]]
  end

  def selected_status
    params[:status].to_s
  end

end
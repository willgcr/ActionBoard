class Tasks::NewTaskComponent < ApplicationComponent
  def initialize(task:, current_user:)
    @task = task
    @current_user = current_user
    super()
  end

  def view_template
    turbo_frame_tag 'tasks_container' do
      turbo_frame_tag(view_context.dom_id(task)) do
        div(class: "px-4 py-6 bg-white rounded-lg border border-gray-200 shadow-sm w-full max-w-full sm:max-w-xl mx-auto overflow-hidden") do
          h2(class: "text-xl font-semibold text-gray-800 mb-4 text-center") { "New Task" }

          form_with(url: tasks_path, method: :post, scope: :task, class: "flex flex-col gap-4", data: { turbo: true }) do |f|
            f.hidden_field(:completed, value: false)

            div(class: "form-control") do
              f.label(:title, class: "label text-sm text-gray-700") { "Title" }
              f.text_field(:title, class: "input input-bordered w-full bg-white text-gray-800 border-gray-300", required: true)
            end

            div(class: "form-control") do
              f.label(:description, class: "label text-sm text-gray-700") { "Description" }
              f.text_area(:description, rows: 3, maxlength: 250, 
                          class: "textarea textarea-bordered w-full bg-white text-gray-800 border-gray-300", required: true)
            end

            div(class: 'flex flex-col sm:flex-row justify-between items-start sm:items-center gap-2 text-xs text-gray-500') do
              div(class: "flex flex-col sm:flex-row gap-1 form-control w-full sm:w-auto") do
                f.label(:list_id, class: "label text-sm text-gray-700") { "List" }

                f.collection_select(:list_id, current_user.available_lists, :id, :title, { prompt: "Choose a list" },
                                    class: "select select-bordered select-sm w-full bg-white text-gray-800 border-gray-300",
                                    required: true)
              end

              span(class: "block sm:text-right") { "Created By: #{current_user.email}" }
            end

            div(class: "flex flex-col sm:flex-row justify-end gap-2 mt-4") do
              a(href: tasks_path, data: { turbo_frame: "_top" }, class: "btn btn-outline w-full sm:w-auto") { "Cancel" }
              f.button(type: "submit", class: "btn btn-neutral w-full sm:w-auto") { "Save" }
            end
          end
        end
      end
    end
  end

  private

  attr_reader :task, :current_user
end
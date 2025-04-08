class Tasks::TaskComponent < ApplicationComponent
  def initialize(task:)
    @task = task
    super()
  end

  def view_template
    turbo_frame_tag(view_context.dom_id(task)) do
      div(class: "px-4 py-4 hover:bg-gray-50 transition-colors text-left hover:cursor-pointer w-full") do
        div(class: "flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4") do

          div(class: "flex gap-3 sm:flex-1 w-full") do
            form_with(model: task, method: :patch, class: "flex items-center pt-1", data: { turbo: true }) do |f|
              f.check_box(:completed, onchange: "this.form.requestSubmit()",
                class: "checkbox checkbox-md text-black border-gray-400")
            end

            div(class: "flex flex-col gap-1 w-full") do
              span(class: "text-md font-medium text-gray-800 break-words #{'line-through text-gray-400' if task.completed}") do
                task.title
              end

              if task.description.present?
                span(class: "text-sm text-gray-700 break-words #{'line-through text-gray-400' if task.completed}") do
                  task.description
                end
              end

              div(class: "flex flex-col sm:flex-row justify-between text-xs text-gray-500 mt-1") do
                span(class: 'flex') { "From list: #{task.list.title}" }
                span(class: 'flex') { "Created By: #{task.list.owner_user.email}" }
              end
            end
          end

          div(class: "flex flex-row gap-2 items-center shrink-0") do
            a(href: edit_task_path(task), data: { turbo_frame: view_context.dom_id(task) },
              class: "btn btn-sm btn-outline hover:border-transparent transition-colors duration-200") do
                svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-4") do |s| s.path stroke_linecap: "round", stroke_linejoin: "round", d: "m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L6.832 19.82a4.5 4.5 0 0 1-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 0 1 1.13-1.897L16.863 4.487Zm0 0L19.5 7.125"end
            end

            form_with(model: task, method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "shrink-0") do |f|
              f.button(type: "submit",
                       class: "btn btn-sm btn-outline btn-error hover:text-white hover:border-transparent transition-colors duration-200") do
                svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-4") do |s| s.path stroke_linecap: "round", stroke_linejoin: "round", d: "m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" end
              end
            end
          end
        end
      end
    end
  end

  private

  attr_reader :task
end
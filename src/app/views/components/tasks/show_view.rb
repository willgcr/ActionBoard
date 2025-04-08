class Tasks::ShowView < ApplicationView
  def initialize(task:)
    @task = task
    super()
  end

  def view_template
    div(class: "fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm flex justify-center items-center z-50") do
      div(class: "bg-white p-6 rounded-lg shadow-lg w-full max-w-md") do
        h2(class: "text-xl font-semibold mb-4") { task.title }

        p(class: "text-gray-700 mb-2") { "Description: #{task.description.presence || 'No description'}" }

        p(class: "text-sm text-gray-500") { "List: #{task.list.title}" }

        div(class: "mt-6 flex justify-end gap-2") do
          a(href: "#", data: { turbo_frame: "_top" }, class: "btn btn-outline") { "Close" }
          a(href: "#", class: "btn btn-neutral") { "Edit" }
        end
      end
    end
  end

  private

  attr_reader :task
end

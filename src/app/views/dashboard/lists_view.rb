class Dashboard::ListsView < ApplicationView
  def initialize(lists:, params:)
    @lists = lists
    @params = params
    super()
  end

  def view_template
    turbo_frame_tag('lists_view', class: "flex flex-col w-full max-w-2xl gap-6 p-6") do
      div(class: "flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4") do
        h2(class: "text-2xl font-semibold text-gray-800") { "Your Lists" }

        div(class: "flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4") do
          form_with(url: user_lists_path, method: :get, data: { turbo_frame: "lists_container" }, class: "flex flex-col sm:flex-row gap-2 sm:gap-4") do |f|
            f.select(:filter, available_filters, { selected: selected_filter },
              class: "select select-bordered bg-white text-gray-800 border-gray-300 w-full sm:w-auto",
              onchange: "this.form.requestSubmit()")
          end

          button_to("New List", new_list_path, method: :get, form: { data: { turbo_frame: "lists_container" } }, class: "btn btn-neutral w-full sm:w-auto")
        end
      end

      turbo_frame_tag "lists_container" do
        if @lists.any?
          div(class: "divide-y divide-gray-200 border border-gray-200 rounded-lg overflow-hidden") do
            @lists.each do |list|
              render Lists::ListComponent.new(list: list)
            end
          end
        else
          div(class: "text-center text-gray-500 mt-12") { "You don’t have any lists yet." }
        end
      end
    end
  end

  private

  attr_reader :lists, :params

  def available_filters
    [["All Lists", ""], ["Owned by me", "owned"], ["Shared with me", "shared"]]
  end

  def selected_filter
    params[:filter].presence if params.present?
  end
end

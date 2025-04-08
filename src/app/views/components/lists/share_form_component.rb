class Lists::ShareFormComponent < ApplicationComponent
  def initialize(list:, error: nil)
    @list = list
    @error = error
    super()
  end

  def view_template
    turbo_frame_tag(view_context.dom_id(list)) do
      turbo_frame_tag "share_form_#{list.id}" do
        div(class: "px-6 py-6 bg-white rounded-lg border border-gray-200 shadow-sm w-full") do
          h2(class: "text-xl font-semibold text-gray-700 mb-2") { "Share List" }

          div(class: "mb-4 text-sm text-gray-600 space-y-1") do
            p { strong(class: "text-gray-800") { "Title: #{list.title}" } }
            p { strong(class: "text-gray-800") { "Description: #{list.description.presence || "No description"}" } }
            p { strong(class: "text-gray-800") { "Shared with: #{list.list_shares.count} user(s)" } }
            if list.shared_users.any?
              div(class: "mt-4") do
                strong(class: "block text-sm text-gray-700 mb-2") { "Shared with:" }

                div(class: "flex flex-wrap gap-2") do
                  list.shared_users.each do |shared_user|
                    span(class: "bg-gray-100 text-gray-800 text-xs font-medium px-2 py-0 rounded-full border border-gray-300 rounded-md") do
                      shared_user.email
                    end
                  end
                end
              end
            end
          end

          if error
            div(class: "bg-red-100 border border-red-300 text-xs text-red-700 font-medium rounded p-3 mb-4") { error }
          end

          form_with(url: share_submit_list_path(list), method: :post, data: { turbo_frame: "share_form_#{list.id}" }, class: "flex flex-col gap-4") do |f|
            div(class: "form-control") do
              f.label(:email, class: "label text-sm text-gray-700") { "Share with a new user" }
              f.email_field(:email, class: "input input-bordered w-full bg-white text-gray-800 border-gray-300", required: true)
            end

            div(class: "flex justify-end gap-2") do
              a(href: lists_path, data: { turbo_frame: "_top" }, class: "btn btn-sm btn-outline") { "Cancel" }
              f.button(type: "submit", class: "btn btn-sm btn-info") { "Share" }
            end
          end
        end
      end
    end
  end

  private

  attr_reader :list, :error
end
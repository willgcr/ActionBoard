# app/views/devise/registrations/edit.html.rb
class Devise::Registrations::EditView < ApplicationView
  def initialize(resource:, resource_name:, devise_mapping:)
    @resource = resource
    @resource_name = resource_name
    @devise_mapping = devise_mapping
    super()
  end

  def view_template
    div(class: "w-full max-w-lg p-6 border border-gray-200 rounded-lg") do
      h2(class: "text-xl font-semibold text-center text-gray-800 mb-6") do
        "Edit #{resource_name.to_s.humanize}"
      end

      div(id: "form-errors") do
        render Auth::ErrorMessageComponent.new(resource: resource)
      end

      form(
        method: "post",
        action: helpers.registration_path(resource_name),
        class: "flex flex-col gap-4"
      ) do
        input(type: "hidden", name: "_method", value: "put")
        input(type: "hidden", name: "authenticity_token", value: helpers.form_authenticity_token)

        div(class: "form-control") do
          label(for: "user_email", class: "label text-sm text-gray-700") { "Email" }

          input(
            type: "email",
            name: "user[email]",
            id: "user_email",
            value: resource.email,
            required: true,
            autofocus: true,
            autocomplete: "email",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        if devise_mapping.confirmable? && resource.pending_reconfirmation?
          div(class: "text-sm text-gray-600 italic") do
            span { "Currently waiting confirmation for: " }
            strong { resource.unconfirmed_email }
          end
        end

        div(class: "form-control") do
          label(for: "user_password", class: "label text-sm text-gray-700") do
            span { "New Password" }
            span(class: "text-xs italic ml-2 text-gray-500") { "(leave blank if you don't want to change it)" }
          end

          input(
            type: "password",
            name: "user[password]",
            id: "user_password",
            autocomplete: "new-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )

          if minimum_password_length
            p(class: "text-xs text-gray-500 mt-1") { "(#{minimum_password_length} characters minimum)" }
          end
        end

        div(class: "form-control") do
          label(for: "user_password_confirmation", class: "label text-sm text-gray-700") { "Confirm new password" }

          input(
            type: "password",
            name: "user[password_confirmation]",
            id: "user_password_confirmation",
            autocomplete: "new-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        div(class: "form-control") do
          label(for: "user_current_password", class: "label text-sm text-gray-700") do
            span { "Current password" }
            span(class: "text-xs italic ml-2 text-gray-500") { "(we need your current password to confirm your changes)" }
          end

          input(
            type: "password",
            name: "user[current_password]",
            id: "user_current_password",
            autocomplete: "current-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        button(type: "submit", class: "btn btn-neutral mt-2") do
          "Update"
        end
      end

      div(class: "mt-8 border-t pt-4") do
        h3(class: "text-sm font-semibold text-gray-800 mb-2") { "Cancel my account" }

        div(class: "text-sm text-gray-600") do
          render_button_to_cancel_account
        end
      end

      div(class: "mt-4 text-sm text-center text-gray-600") do
        a(href: helpers.root_path, class: "link link-hover") { "Back" }
      end
    end
  end

  private

  attr_reader :resource, :resource_name, :devise_mapping

  def minimum_password_length
    @minimum_password_length
  end

  def render_button_to_cancel_account
    form(
      method: "post",
      action: helpers.registration_path(resource_name),
      class: "inline-block"
    ) do
      input(type: "hidden", name: "_method", value: "delete")
      input(type: "hidden", name: "authenticity_token", value: helpers.form_authenticity_token)

      button(
        type: "submit",
        class: "btn btn-sm bg-red-500 hover:bg-red-600 text-white rounded shadow-sm transition",
        data: {
          turbo_confirm: "Are you sure?",
          confirm: "Are you sure?"
        }
      ) do
        "Cancel my account"
      end
    end
  end
end
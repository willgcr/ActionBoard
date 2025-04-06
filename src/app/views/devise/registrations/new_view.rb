class Devise::Registrations::NewView < ApplicationView
  def initialize(resource:)
    @resource = resource
    super()
  end

  def view_template
    div(class: "w-full max-w-md p-6 border border-gray-200 rounded-lg") do
      h2(class: "text-xl font-semibold text-center text-gray-800 mb-6") do
        "Sign up"
      end

      div(id: "form-errors") do
        render Auth::ErrorMessageComponent.new(resource: resource)
      end

      form(method: "post", action: helpers.registration_path(resource_name), class: "flex flex-col gap-4") do
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

        div(class: "form-control") do
          label(for: "user_password", class: "label text-sm text-gray-700") do
            span { "Password" }
            if minimum_password_length
              span(class: "ml-1 text-xs text-gray-500") { "(#{minimum_password_length} characters minimum)" }
            end
          end

          input(
            type: "password",
            name: "user[password]",
            id: "user_password",
            required: true,
            autocomplete: "new-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        div(class: "form-control") do
          label(for: "user_password_confirmation", class: "label text-sm text-gray-700") { "Confirm Password" }

          input(
            type: "password",
            name: "user[password_confirmation]",
            id: "user_password_confirmation",
            required: true,
            autocomplete: "new-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        button(type: "submit", class: "btn btn-neutral mt-2") do
          "Sign up"
        end
      end

      div(class: "mt-6 text-sm text-center text-gray-600") do
        a(href: helpers.new_user_session_path, class: "link link-hover") { "Already have an account? Login" }
      end
    end
  end

  private

  attr_reader :resource

  def resource_name
    :user
  end

  def minimum_password_length
    @minimum_password_length
  end
end

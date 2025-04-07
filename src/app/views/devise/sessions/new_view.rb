class Devise::Sessions::NewView < ApplicationView
  def initialize(resource:)
    @resource = resource
    super()
  end

  def view_template
    div(class: "w-full max-w-md p-6 border border-gray-200 rounded-lg") do
      h2(class: "text-xl font-semibold text-center text-gray-800 mb-6") do
        "Sign in to your account"
      end

      form(
        method: "post",
        action: view_context.session_path(:user),
        class: "flex flex-col gap-4"
      ) do
        input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)

        div(class: "form-control") do
          label(for: "user_email", class: "label text-sm text-gray-700") { "Email" }

          input(
            type: "email",
            name: "user[email]",
            id: "user_email",
            required: true,
            autofocus: true,
            autocomplete: "email",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        div(class: "form-control") do
          label(for: "user_password", class: "label text-sm text-gray-700") { "Password" }

          input(
            type: "password",
            name: "user[password]",
            id: "user_password",
            required: true,
            autocomplete: "current-password",
            class: "input input-bordered w-full bg-white text-gray-800 border-gray-300"
          )
        end

        button(type: "submit", class: "btn btn-neutral mt-2") do
          "Sign in"
        end
      end

      div(class: "mt-6 text-sm text-center text-gray-600 space-y-2") do
        div do
          a(href: new_user_password_path, class: "link link-hover") { "Forgot your password?" }
        end
        div do
          a(href: new_user_registration_path, class: "link link-hover") { "Create an account" }
        end
      end
    end
  end

  private

  attr_reader :resource
end

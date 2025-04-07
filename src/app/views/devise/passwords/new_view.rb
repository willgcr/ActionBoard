class Devise::Passwords::NewView < ApplicationView
  def initialize(resource:)
    @resource = resource
    super()
  end

  def view_template    
    div(class: "w-full max-w-md p-6 border border-gray-200 rounded-lg") do
      h2(class: "text-xl font-semibold text-center text-gray-800 mb-6") do
        "Forgot your password?"
      end

      form(
        method: "post",
        action: view_context.password_path(:user),
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

        button(type: "submit", class: "btn btn-neutral mt-2") do
          "Send reset instructions"
        end
      end

      div(class: "mt-6 text-sm text-center text-gray-600 space-x-4") do
        a(href: new_user_session_path, class: "link link-hover") { "Login" }
        a(href: new_user_registration_path, class: "link link-hover") { "Register" }
      end
    end
  end

  private

  attr_reader :resource
end
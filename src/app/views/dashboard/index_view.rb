class Dashboard::IndexView < ApplicationView

  def view_template
    div(class: "flex flex-col w-full gap-4 text-center p-10") do
      h1(class: "text-4xl font-bold text-black") { render Base::LogoComponent.new }
      p(class: "text-md text-gray-500 mt-2 font-bold") { "You are logged in as #{current_user.email}" }
      div(class: "flex justify-center gap-4 mt-6") do
        a(href: edit_user_registration_path, class: "btn btn-outline") { "Edit Account" }
        
        form(method: "post", action: "/logout") do
          input(type: "hidden", name: "_method", value: "delete")
          input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
          button(type: "submit", class: "btn btn-neutral") { "Logout" }
        end
      end
    end
  end
end

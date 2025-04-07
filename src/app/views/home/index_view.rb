class Home::IndexView < ApplicationView

  def view_template
    div(class: "flex flex-col w-full gap-4 text-center p-10") do
      p(class: "text-md text-gray-500 mt-2 font-bold") { "Welcome to ActionBoard!" }
      div(class: "flex justify-center gap-4") do
        a(href: edit_user_registration_path, class: "btn btn-neutral") { "Login" }
        a(href: new_user_registration_path, class: "btn btn-outline") { "Register" }
      end
    end
  end
end

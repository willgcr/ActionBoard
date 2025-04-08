class Home::IndexView < ApplicationView
  def view_template
    div(class: "flex flex-col items-center justify-center w-full bg-white gap-8 px-6 py-12") do
      h1(class: "text-3xl sm:text-4xl font-bold text-gray-800 text-center") do
        "Organize. Collaborate. Achieve."
      end

      p(class: "text-gray-600 text-md sm:text-lg max-w-xl text-center leading-relaxed") do
        "ActionBoard is a modern and collaborative task management tool that helps you organize your to-dos, share lists with others, and keep track of progress—all in one place."
      end

      div(class: "flex flex-col sm:flex-row gap-4 mt-4") do
        a(href: new_user_session_path, class: "btn btn-neutral") { "Login" }
        a(href: new_user_registration_path, class: "btn btn-outline") { "Create an Account" }
      end

      div(class: "mt-10 text-xs text-gray-400") do
        "Secure. Fast. Powered by Rails, Turbo, and Tailwind."
      end
    end
  end
end
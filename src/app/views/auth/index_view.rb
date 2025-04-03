class Auth::IndexView < ApplicationView
  def view_template
    div(class: "text-center p-10") do
      h1(class: "text-4xl font-bold text-blue-600") { "Welcome to ActionBoard!" }
      p(class: "text-lg text-gray-600 mt-2 font-bold") { "Now using Phlex + Tailwind!" }
    end
  end
end

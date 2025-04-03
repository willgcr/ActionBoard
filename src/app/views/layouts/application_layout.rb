class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  def view_template(&)
    doctype

    html do
      head do
        title { "ActionBoard" }
        meta name: "viewport", content: "width=device-width, initial-scale=1"
        meta charset: "UTF-8"
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag 'tailwind', 'data-turbo-track': 'reload'
      end

      body(class: "bg-gray-100 text-gray-900 flex flex-col min-h-screen") do
        header(class: "bg-blue-600 text-white p-4 text-center text-xl font-bold") do
          span { "ActionBoard" }
        end

        main(class: "container mx-auto p-6 flex-grow", &)

        footer(class: "bg-gray-800 text-white text-center p-4 mt-8") do
          span { "© #{Time.now.year} ActionBoard. All rights reserved." }
        end
      end
    end
  end
end

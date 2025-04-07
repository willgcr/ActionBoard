class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  def view_template(&)
    doctype

    html do
      head do
        title { "Welcome to ActionBoard!" }
        meta name: "viewport", content: "width=device-width, initial-scale=1"
        meta charset: "UTF-8"
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag 'application', data: { turbo_track: 'reload' }
        javascript_include_tag 'application', type: 'module', data: { turbo_track: 'reload' }
      end

      body(class: "bg-gray-100 text-gray-900 flex flex-col min-h-screen") do
        render Base::NavbarComponent.new
        main(class: "container mx-auto p-5 lg:my-5 flex flex-grow items-center justify-center bg-white rounded-none lg:rounded-lg", &)
        render Base::FooterComponent.new
      end
    end
  end
end

class Base::NavbarComponent < ApplicationComponent

  def view_template
    if user_signed_in?
      private_header
    else
      public_header
    end
  end

  private

  def public_header
    header(class: "bg-black text-white p-6 text-center text-2xl font-extrabold tracking-wide") do
      a(href: view_context.root_path) { render Base::LogoComponent.new(dark_bg: true) }
    end
  end

  def private_header
    div(class: "drawer drawer-end lg:hidden") do
      input(id: "mobile-drawer", type: "checkbox", class: "drawer-toggle")

      div(class: "drawer-content") do
        header(class: "bg-white shadow-xs px-4 py-3 flex justify-between items-center") do
          a(href: view_context.root_path, class: "text-xl font-bold text-gray-800") do
            render Base::LogoComponent.new
          end
          label(for: "mobile-drawer", class: "btn btn-ghost btn-sm") do
            svg(
              xmlns: "http://www.w3.org/2000/svg",
              viewBox: "0 0 24 24",
              fill: "none",
              stroke_width: "1.5",
              stroke: "currentColor",
              class: "size-6"
            ) do |s|
              s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d: "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
              )
            end
          end
        end
      end
      div(class: "drawer-side bg-white z-50 fixed") do
        label(for: "mobile-drawer", class: "drawer-overlay")
        ul(class: "menu p-4 w-[80%] min-h-full bg-white text-gray-700 gap-2") do
          li(class: 'border border-gray-100 rounded-md') { a(href: "#") { span { "📋" }; span { "Lists" } } }
          li(class: 'border border-gray-100 rounded-md') { a(href: "#") { span { "✅" }; span { "Tasks" } } }
          li(class: 'border border-gray-100 rounded-md') { a(href: view_context.edit_user_registration_path) { span { "👤" }; span { "Account" } } }
            form(method: "post", action: "/logout") do
              input(type: "hidden", name: "_method", value: "delete")
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              button(type: "submit", class: "btn btn-error btn-sm w-full text-white") { "Logout" }
          end
        end
      end
    end

    header(class: "bg-white shadow-xs px-4 py-3 justify-between items-center hidden lg:flex") do
      a(href: view_context.root_path, class: "text-xl font-bold text-gray-800") do
        render Base::LogoComponent.new
      end
      nav(class: "flex gap-4 items-center") do
        a(href: "#", class: "btn btn-sm btn-ghost") { span { "Lists" } }
        a(href: "#", class: "btn btn-sm btn-ghost") { span { "Tasks" } }
        a(href: view_context.edit_user_registration_path, class: "btn btn-sm btn-ghost") { span { "Account" } }
        form(method: "post", action: "/logout", class: "inline") do
          input(type: "hidden", name: "_method", value: "delete")
          input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
          button(type: "submit", class: "btn btn-sm btn-error text-white") { "Logout" }
        end
      end
    end
  end
end

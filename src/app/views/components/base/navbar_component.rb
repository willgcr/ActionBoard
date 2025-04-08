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
      a(href: root_path) { render Base::LogoComponent.new(dark_bg: true) }
    end
  end

  def private_header
    div(class: "drawer drawer-end lg:hidden") do
      input(id: "mobile-drawer", type: "checkbox", class: "drawer-toggle")

      div(class: "drawer-content") do
        header(class: "bg-white shadow-xs px-4 py-3 flex justify-between items-center") do
          a(href: root_path, class: "text-xl font-bold text-gray-800") do
            render Base::LogoComponent.new
          end
          label(for: "mobile-drawer", class: "btn btn-ghost btn-sm") do
            svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-6") do |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5")
            end
          end
        end
      end
      div(class: "drawer-side bg-white z-50 fixed") do
        label(for: "mobile-drawer", class: "drawer-overlay")
        ul(class: "menu p-4 w-[80%] min-h-full bg-white text-gray-700 gap-2") do
          li(class: 'border border-gray-100 rounded-md') do
            a(href: root_path) do
              svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-5") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25") }
              span { "Home" }
            end
          end
          li(class: 'border border-gray-100 rounded-md') do
            a(href: user_lists_path) do 
              svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-5") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M8.25 6.75h12M8.25 12h12m-12 5.25h12M3.75 6.75h.007v.008H3.75V6.75Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0ZM3.75 12h.007v.008H3.75V12Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm-.375 5.25h.007v.008H3.75v-.008Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z") }
              span { "Lists" }
            end
          end
          li(class: 'border border-gray-100 rounded-md') do
            a(href: user_tasks_path) do
              svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-5") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z") }
              span { "Tasks" }
            end
          end
          li(class: 'border border-gray-100 rounded-md') do
            a(href: edit_user_registration_path) do
              svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-5") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z") }
              span { "Account" }
            end
          end
          form(method: "post", action: "/logout") do
            input(type: "hidden", name: "_method", value: "delete")
            input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
            button(type: "submit", class: "btn btn-error btn-sm w-full text-white") { "Logout" }
          end
        end
      end
    end

    header(class: "bg-white shadow-xs px-4 py-3 justify-between items-center hidden lg:flex") do
      a(href: root_path, class: "text-xl font-bold text-gray-800") do
        render Base::LogoComponent.new
      end

      nav(class: "flex gap-[100px] items-center") do
        a(href: user_lists_path, class: "btn btn-sm btn-ghost flex gap-1 items-center hover:text-white text-black") do
          svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-4") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M8.25 6.75h12M8.25 12h12m-12 5.25h12M3.75 6.75h.007v.008H3.75V6.75Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0ZM3.75 12h.007v.008H3.75V12Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm-.375 5.25h.007v.008H3.75v-.008Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z") }
          span { "Lists" }
        end

        a(href: user_tasks_path, class: "btn btn-sm btn-ghost flex gap-1 items-center hover:text-white text-black") do
          svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-4") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z") }
          span { "Tasks" }
        end

        a(href: edit_user_registration_path, class: "btn btn-sm btn-ghost flex gap-1 items-center hover:text-white text-black") do
          svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke_width: "1.5", stroke: "currentColor", class: "size-4") { |s| s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z") }
          span { "Account" }
        end

        form(method: "post", action: "/logout", class: "inline") do
          input(type: "hidden", name: "_method", value: "delete")
          input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
          button(type: "submit", class: "btn btn-sm btn-error text-white") { "Logout" }
        end
      end
    end
  end
end

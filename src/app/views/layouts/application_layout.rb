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
        stylesheet_link_tag 'application', data: { turbo_track: 'reload' }
        javascript_include_tag 'application', type: 'module', data: { turbo_track: 'reload' }
      end

      body(class: "bg-gray-100 text-gray-900 flex flex-col min-h-screen") do
        public_header
        main(class: "container mx-auto p-5 my-5 flex flex-grow items-center justify-center bg-white rounded-lg", &)
        public_footer
      end
    end
  end

  def public_header
    header(class: "bg-black text-white p-6 text-center text-2xl font-extrabold tracking-wide") do
      a(href: helpers.root_path) { render LogoComponent.new(dark_bg: true) }
    end
  end

  def private_header
  end

  def public_footer
    footer(class: "bg-black text-white text-center p-4 mt-8") do
      span(class: 'text-sm') do
        a(href: "https://github.com/willgcr/ActionBoard", target: "_blank", class: 'flex flex-row items-center justify-center gap-2') do
          span(class: 'flex w-[15px]') do
            svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "currentColor", class: "w-6 h-6") { |s| s.path(fill_rule: "evenodd", clip_rule: "evenodd", d: "M12 0C5.37 0 0 5.37 0 12c0 5.3 3.438 9.8 8.205 11.385.6.113.82-.26.82-.577v-2.234c-3.338.726-4.033-1.415-4.033-1.415-.546-1.387-1.333-1.756-1.333-1.756-1.09-.745.082-.729.082-.729 1.205.084 1.838 1.237 1.838 1.237 1.07 1.835 2.807 1.305 3.492.997.107-.776.42-1.305.763-1.605-2.665-.3-5.467-1.332-5.467-5.93 0-1.31.467-2.382 1.235-3.222-.123-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.3 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.29-1.552 3.296-1.23 3.296-1.23.653 1.653.241 2.874.118 3.176.77.84 1.232 1.913 1.232 3.222 0 4.61-2.807 5.625-5.48 5.92.431.372.815 1.103.815 2.222v3.293c0 .32.218.694.825.576C20.565 21.796 24 17.297 24 12c0-6.63-5.37-12-12-12z") }
          end
          span(class: 'flex italic') { "ActionBoard" }
        end
        span {" © #{Time.now.year} Released under the GPLv3 License"}
        br
        span { "Built with 💛 in Brazil 🇧🇷" }
      end
    end
  end

  def private_footer
  end
end

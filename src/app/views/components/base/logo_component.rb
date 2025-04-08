class Base::LogoComponent < ApplicationComponent

  def initialize(dark_bg: false)
    @dark_bg = dark_bg
  end

  def view_template
    div(class: 'flex flex-row items-center justify-center gap-4') do
      img(src: helpers.asset_path("logo.png"),alt: "ActionBoard", class: "h-10 w-10 rounded-xl")
      span(class: logo_classes) { "ActionBoard" }
    end
  end

  private

  def logo_classes
    base = "flex drop-shadow-sm font-logo text-xl font-bold"
    if @dark_bg
      "#{base} text-transparent bg-clip-text bg-gradient-to-r from-white to-gray-400"
    else
      "#{base} text-transparent bg-clip-text bg-gradient-to-r from-black to-gray-600"
    end
  end
end

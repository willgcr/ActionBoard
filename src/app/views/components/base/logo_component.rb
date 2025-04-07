class Base::LogoComponent < ApplicationComponent

  def initialize(dark_bg: false)
    @dark_bg = dark_bg
  end

  def view_template
    span(class: logo_classes) { "ActionBoard" }
  end

  private

  def logo_classes
    base = "drop-shadow-sm font-logo text-xl font-bold"
    if @dark_bg
      "#{base} text-transparent bg-clip-text bg-gradient-to-r from-white to-gray-400"
    else
      "#{base} text-transparent bg-clip-text bg-gradient-to-r from-black to-gray-600"
    end
  end
end

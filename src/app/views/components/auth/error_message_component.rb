class Auth::ErrorMessageComponent < ApplicationComponent
  def initialize(resource:)
    @resource = resource
  end

  def view_template
    return if @resource.errors.empty?

    div(id: "error_explanation", data: { turbo_cache: false }) do
      h2(class: "text-red-700 font-semibold text-sm mb-1") do
        I18n.t(
          "errors.messages.not_saved",
          count: @resource.errors.count,
          resource: @resource.class.model_name.human.downcase
        )
      end

      ul(class: "list-disc list-inside text-sm text-red-600 space-y-1") do
        @resource.errors.full_messages.each do |message|
          li { message }
        end
      end
    end
  end
end

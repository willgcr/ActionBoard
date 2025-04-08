class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::OptionsForSelect
  include Phlex::Rails::Helpers::TurboFrameTag
  include ActionView::RecordIdentifier
  include Rails.application.routes.url_helpers

  register_value_helper :current_user
  register_value_helper :session
  register_value_helper :can?
  register_value_helper :user_signed_in?
  register_value_helper :notice
  register_value_helper :alert
  register_value_helper :flash

  def default_url_options
    Rails.application.config.action_mailer.default_url_options || {}
  end
end
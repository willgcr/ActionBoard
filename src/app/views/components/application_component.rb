class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers
  include Rails.application.routes.url_helpers

  register_value_helper :current_user
  register_value_helper :session
  register_value_helper :can?
  register_value_helper :user_signed_in?

  def default_url_options
    Rails.application.config.action_mailer.default_url_options || {}
  end
end
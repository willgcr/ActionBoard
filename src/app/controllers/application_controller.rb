class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  layout -> { ApplicationLayout }

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    root_path
  end
end

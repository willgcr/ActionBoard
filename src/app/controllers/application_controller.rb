class ApplicationController < ActionController::Base
  layout -> { ApplicationLayout }

  before_action :authenticate_user!

end

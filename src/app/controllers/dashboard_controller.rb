class DashboardController < ApplicationController
  def index
    render Dashboard::IndexView.new(current_user:)
  end
end

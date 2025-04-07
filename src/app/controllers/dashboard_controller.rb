class DashboardController < ApplicationController
  def index
    render Dashboard::IndexView.new
  end
end

class HomeController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    render Home::IndexView.new
  end
end

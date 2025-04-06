class SetupController < ApplicationController
  def index
    render Setup::IndexView.new
  end
end

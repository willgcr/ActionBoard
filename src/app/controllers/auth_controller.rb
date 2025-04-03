class AuthController < ApplicationController
  def index
    render Auth::IndexView.new
  end
end

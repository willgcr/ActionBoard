class AuthController < ApplicationController
  def index
    render plain: "welcome to action board", status: :ok
  end
end

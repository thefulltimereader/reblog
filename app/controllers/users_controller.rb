class UsersController < ApplicationController
  def new
    @title = "Reblog:sign up"
  end

  def show
    @user = User.find(params[:id])
  end

end

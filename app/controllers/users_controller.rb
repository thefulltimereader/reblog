class UsersController < ApplicationController
  def new
    @title = "Reblog:sign up"
  end

  def index
    @users = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end

class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  def new
    @title = "Sign up"
    @user = User.new
  end

  def index
    @title = "All users"
#    @users = User.all
# can't do below in cims   
    @users = User.paginate( :page => params[:page])

  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
 #   @posts = @user.posts
    @posts = @user.posts.all.paginate(:page => params[:page], :per_page => 3)
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Reblog!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end  
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit #{@user.name}"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit profile"
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

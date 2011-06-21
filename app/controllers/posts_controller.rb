class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end


  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end



  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy
    redirect_back_or root_path

  end


  private

    def authorized_user
      @post = Post.find(params[:id])
      redirect_to root_path unless current_user?(@post.user)
    end
end

class PagesController < ApplicationController
  

  def home
    @title = "Home"
    @post = Post.new if signed_in?
    @feed_items = current_user.feed.paginate(:page=>params[:page]) if signed_in?
    @posts = current_user.posts.paginate(:page =>params[:page], :per_page => 3) if signed_in?
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end

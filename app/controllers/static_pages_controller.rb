class StaticPagesController < ApplicationController
  def home
    if signed_in?
        @post = current_user.posts.build
        #@post = Post.all
        #@feed_items = current_user.feed.paginate(page: params[:page])
        @feed_items = current_user.friend_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
end

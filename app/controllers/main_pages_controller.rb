class MainPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @users = User.paginate(page: params[:page]).order("RAND()").limit(5)
    end
  end

  def protection 
  end
end

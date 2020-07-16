class FavoriteRelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    current_user.favo(post)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = FavoriteRelationship.find(params[:id]).post
    current_user.unfavo(post)
    redirect_back(fallback_location: root_url)
  end
end

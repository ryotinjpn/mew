class LikeRelationshipsController < ApplicationController
  before_action :authenticate_user!
  
    def create
      post = Post.find(params[:post_id])
      current_user.like(post)
      redirect_back(fallback_location: root_url)
    end
  
    def destroy
      post = LikeRelationship.find(params[:id]).post
      current_user.unlike(post)
      redirect_back(fallback_location: root_url)
    end
  end
end

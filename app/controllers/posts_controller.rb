class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました!"
      redirect_to root_url
    else
      flash[:alert] = "キャプションとファイル(30MB未満)は必須です！ "
      @feed_items = []
      redirect_to root_url
    end
  end

  #投稿の詳細
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end
    
  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end
    
  private
  def post_params
    params.require(:post).permit(:content, :picture)
  end
        
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

end

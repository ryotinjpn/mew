class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show edit update destroy following followers likes favos]
  before_action :dm, only: %i[show following followers likes favos]
  def index
    @users = User.paginate(page: params[:page]).order("RAND()").all
  end

  def show
    @posts = @user.posts.paginate(page: params[:page])
  end

  def following
    @title = "フォロー中"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def likes
    @title = "いいね"
    @posts = @user.likes.paginate(page: params[:page])
    render 'show_like'
  end

  def favos
    @title = "お気に入り"
    @posts = @user.favos.paginate(page: params[:page])
    render 'show_favo'
  end

  def dm
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def search
    @users = User.search(params[:keyword])
    unless @users.present?
      flash[:alert] = "一致するユーザーはいません"
      redirect_to search_users_path
    end
  end
end

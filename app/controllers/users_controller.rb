class UsersController < ApplicationController
  before_action :authenticate_user!,  only: [:index, :show, :edit, :update, :destroy,:following, :followers, :likes]
  before_action :dm,  only: [:show,:following, :followers, :likes]
  def index
    @users = User.paginate(page: params[:page]).order("RAND()").all
    #@users = User.where(activated: true).paginate(page: params[:page])
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

  def dm
    @user  = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
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
end
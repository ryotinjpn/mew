class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  
  has_many :active_relationships, class_name:  "Relationship", 
                                  foreign_key: "follower_id", 
                                  dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :comments
  
  has_many :like_relationships, dependent: :destroy
  has_many :likes, through: :like_relationships, source: :post

  has_many :favorite_relationships, dependent: :destroy
  has_many :favos, through: :favorite_relationships, source: :post

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  mount_uploader :image, PictureUploader

  attr_accessor :current_password

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # マイクロポストをライクする
  def like(post)
    likes << post
  end

  # マイクロポストをライク解除する
  def unlike(post)
    like_relationships.find_by(post_id: post.id).destroy
  end

  # 現在のユーザーがライクしていたらtrueを返す
  def likes?(post)
    likes.include?(post)
  end

  def favo(post)
    favos << post
  end

  # マイクロポストをライク解除する
  def unfavo(post)
    favorite_relationships.find_by(post_id: post.id).destroy
  end

  # 現在のユーザーがライクしていたらtrueを返す
  def favos?(post)
    favos.include?(post)
  end

  def update_with_password(params, * options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
      update_attributes(params, * options)
  end

  def self.search(search)
    return User.all unless search
    User.where('name LIKE(?)', "%#{search}%")
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy

  # ユーザーのステータスフィードを返す
  def feed
    Post.where("user_id = ?", id)
  end
end

class Post < ApplicationRecord
  has_many :comments
  has_many :like_relationships, dependent: :destroy
  has_many :liked_by, through: :like_relationships, source: :user
  has_many :favorite_relationships, dependent: :destroy
  has_many :favoed_by, through: :favorite_relationships, source: :user
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validates :picture, presence: true
  validate  :picture_size 

  def self.search(search)
    return Post.all unless search
    Post.where('content LIKE(?)', "%#{search}%")
  end

  private
  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 30.megabytes
      errors.add(:picture, "30MB未満にして下さい")
    end
  end
end

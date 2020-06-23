class Post < ApplicationRecord
  has_many :comments
  has_many :like_relationships, dependent: :destroy
  has_many :liked_by, through: :like_relationships, source: :user
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validates :picture, presence: true
  #validate  :picture_size

  private
  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end

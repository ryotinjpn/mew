class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  default_scope -> { order(created_at: :desc) }

  validates :body, presence: true
end

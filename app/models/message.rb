class Message < ApplicationRecord
  belongs_to :user
  has_many :message_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :message_tags, dependent: :destroy

  validates :body, presence: true
  validates :user_id, presence: true
end

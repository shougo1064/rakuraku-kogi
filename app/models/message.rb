class Message < ApplicationRecord
  belongs_to :user
  has_many :message_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :message_tags, dependent: :destroy
end

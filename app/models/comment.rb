class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message

  validates :body, presence: true
  validates :user_id, presence: true
  validates :message_id, presence: true
end

class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  validates :user_id, presence: true
  validates :follower_id, presence: true
end

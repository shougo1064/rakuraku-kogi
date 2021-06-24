# == Schema Information
#
# Table name: message_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_message_likes_on_message_id  (message_id)
#  index_message_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
class MessageLike < ApplicationRecord
  belongs_to :user
  belongs_to :message

  validates :user_id, presence: true
  validates :message_id, presence: true
end

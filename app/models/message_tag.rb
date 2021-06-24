# == Schema Information
#
# Table name: message_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_message_tags_on_message_id  (message_id)
#  index_message_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (tag_id => tags.id)
#
class MessageTag < ApplicationRecord
  belongs_to :message
  belongs_to :tag

  validates :message_id, presence: true
  validates :tag_id, presence: true
end

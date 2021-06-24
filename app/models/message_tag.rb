class MessageTag < ApplicationRecord
  belongs_to :message
  belongs_to :tag

  validates :message_id, presence: true
  validates :tag_id, presence: true
end

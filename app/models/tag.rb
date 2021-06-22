class Tag < ApplicationRecord
  has_many :message_tags, dependent: :destroy
end

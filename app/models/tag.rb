class Tag < ApplicationRecord
  has_many :message_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }
end

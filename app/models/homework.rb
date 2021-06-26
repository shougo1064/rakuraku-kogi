# == Schema Information
#
# Table name: homeworks
#
#  id         :bigint           not null, primary key
#  action     :datetime
#  body       :text
#  deadline   :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_homeworks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Homework < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 50 }
  validates :action, presence: true
  validate :pretend_ago
  validates :deadline, presence: true
  validates :user_id, presence: true

  def pretend_ago
    errors.add(:action, "は、今日を含む過去の日付を入力して下さい") if action.nil? || action < Time.zone.today
  end
end

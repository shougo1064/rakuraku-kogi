class Homework < ApplicationRecord
  belongs_to :user

  validates :title, presenve: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 50 }
  validates :action, presence: true, pretend_ago: true
  validates :deadline, presence: true
  validates :user_id, presence: true

  def pretend_ago
    errors.add(:action, "は、今日を含む過去の日付を入力して下さい") if action.nil? || action < Data.today
  end
end

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
FactoryBot.define do
  factory :homework do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }
    action { Faker::Date.between(from: Time.zone.today, to: 1.months.since) }
    deadline { Faker::Date.between(from: Time.zone.today, to: 2.days.ago) }
    user
  end
end

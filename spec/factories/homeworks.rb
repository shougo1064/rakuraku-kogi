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
    title { "MyString" }
    body { "MyText" }
    action { "2021-06-22 19:47:59" }
    deadline { "2021-06-22 19:47:59" }
    user { nil }
  end
end

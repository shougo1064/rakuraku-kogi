# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  boey       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_message_id  (message_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    boey { "MyText" }
    user { nil }
    message { nil }
  end
end

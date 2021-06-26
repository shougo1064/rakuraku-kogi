# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint
#  following_id :bigint
#
# Indexes
#
#  index_relationships_on_follower_id                   (follower_id)
#  index_relationships_on_following_id                  (following_id)
#  index_relationships_on_following_id_and_follower_id  (following_id,follower_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
FactoryBot.define do
  factory :relationship do
    follower { create(:user).id }
    following { create(:user).id }
  end
end

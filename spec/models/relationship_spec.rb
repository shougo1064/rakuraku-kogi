# == Schema Information
#
# Table name: relationships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_relationships_on_follow_id              (follow_id)
#  index_relationships_on_user_id                (user_id)
#  index_relationships_on_user_id_and_follow_id  (user_id,follow_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (follow_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:follower) { create(:user) }
  context "ユーザーとフォロワーの id が存在するとき" do
    let(:follow) { build(:follow, user_id: user.id, follower_id: follower.id) }
    fit "他のユーザーがフォローできる" do
      expect(follow).to be_valid
    end
  end
  context "ユーザーの id が存在しないとき" do
    let(:follow) { build(:follow, user_id: nil, follower_id: follower.id) }
    fit "他のユーザーがフォローできない" do
      expect(follow).to be_invalid
    end
  end
  context "フォロワーの id が存在しないとき" do
    let(:follow) { build(:follow, user_id: user.id, follower_id: nil) }
    fit "他のユーザーがフォローできない" do
      expect(follow).to be_invalid
    end
  end
end

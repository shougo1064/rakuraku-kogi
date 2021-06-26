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
require "rails_helper"

RSpec.describe Relationship, type: :model do
  context "フォローする側とフォローされる側の id が存在するとき" do
    let(:following) { create(:user) }
    let(:follower) { create(:user) }
    let(:relationship) { build(:relationship, following_id: following.id, follower_id: follower.id) }
    it "他のユーザーがフォローできる" do
      expect(relationship).to be_valid
    end
  end

  context "フォローする側の id が存在しないとき" do
    let(:follower) { create(:user) }
    let(:relationship) { build(:relationship, following_id: nil, follower_id: follower.id) }
    it "エラーする" do
      expect(relationship).to be_invalid
      expect(relationship.errors.messages[:following]).to eq ["must exist"]
      expect(relationship.errors.messages[:following_id]).to eq ["can't be blank"]
    end
  end

  context "フォローされる側の id が存在しないとき" do
    let(:following) { create(:user) }
    let(:relationship) { build(:relationship, following_id: following.id, follower_id: nil) }
    it "エラーする" do
      expect(relationship).to be_invalid
      expect(relationship.errors.messages[:follower]).to eq ["must exist"]
      expect(relationship.errors.messages[:follower_id]).to eq ["can't be blank"]
    end
  end
end

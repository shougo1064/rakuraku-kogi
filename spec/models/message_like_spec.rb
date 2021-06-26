# == Schema Information
#
# Table name: message_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_message_likes_on_message_id  (message_id)
#  index_message_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe MessageLike, type: :model do
  let(:user) { create(:user) }
  let(:message) { create(:message) }
  context "ユーザーとユーザーのメッセージの id が存在するとき" do
    let(:message_like) { build(:message_like, user_id: user.id, message_id: message.id) }
    it "いいねできる" do
      expect(message_like).to be_valid
    end
  end

  context "ユーザーの id が存在しないとき" do
    let(:message_like) { build(:message_like, user_id: nil, message_id: message.id) }
    it "いいねできない" do
      expect(message_like).to be_invalid
    end
  end

  context "ユーザーのメッセージの id が存在しないとき" do
    let(:message_like) { build(:message_like, user_id: user.id, message_id: nil) }
    it "　いいねできない" do
      expect(message_like).to be_invalid
    end
  end
end

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  context "body が指定されているとき" do
    let(:message) { build(:message, user: user) }
    it "メッセージが投稿できる" do
      expect(message).to be_valid
    end
  end

  context "body が指定されていないとき" do
    let(:message) { build(:message, user: user, body: nil) }
    it "メッセージが投稿できない" do
      expect(message).to be_invalid
    end
  end
end

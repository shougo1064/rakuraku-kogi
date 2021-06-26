# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
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
require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:message) { create(:message) }
  context "body が指定されているとき" do
    let(:comment) { build(:comment, user: user, message: message) }
    it "コメントできる" do
      expect(comment).to be_valid
    end
  end

  context "body が指定されていないとき" do
    let(:comment) { build(:comment, body: nil, user: user, message: message) }
    it "コメントできない" do
      expect(comment).to be_invalid
    end
  end
end

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
require "rails_helper"

RSpec.describe Homework, type: :model do
  let(:user) { create(:user) }
  context "必要な情報が全て揃っているとき" do
    let(:homework) { build(:homework, user: user) }
    it "課題が作成できる" do
      expect(homework).to be_valid
    end
  end

  context "title が指定されていないとき" do
    let(:homework) { build(:homework, title: nil, user: user) }
    it "課題が作成できない" do
      expect(homework).to be_invalid
    end
  end

  context "body が指定されていないとき" do
    let(:homework) { build(:homework, body: nil, user: user) }
    it "課題が作成できない" do
      expect(homework).to be_invalid
    end
  end

  context "課題実践日が指定されていないとき" do
    let(:homework) { build(:homework, action: nil, user: user) }
    it "課題が作成できない" do
      expect(homework).to be_invalid
    end
  end

  context "課題実践日を今日より前に指定したとき" do
    let(:homework) { build(:homework, user: user, action: 1.days.ago) }
    it "課題が作成できない" do
      expect(homework).to be_invalid
    end
  end

  context "課題締切日が指定されていないとき" do
    let(:homework) { build(:homework, deadline: nil, user: user) }
    it "課題が作成できない" do
      expect(homework).to be_invalid
    end
  end
end

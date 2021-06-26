# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  context "name が指定されているとき" do
    let(:tag) { build(:tag) }
    it "メッセージにタグ付けできる" do
      expect(tag).to be_valid
    end
  end

  context "name が指定されていないとき" do
    let(:tag) { build(:tag, name: nil) }
    it "メッセージにタグ付けできない" do
      expect(tag).to be_invalid
    end
  end
end

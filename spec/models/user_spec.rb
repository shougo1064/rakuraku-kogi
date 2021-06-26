# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "name, email, password が指定されているとき" do
    let(:user) { build(:user) }
    it "ユーザーが作られる" do
      expect(user).to be_valid
    end
  end

  context "name が指定されていないとき" do
    let(:user) { build(:user, name: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.messages[:name]).to eq ["can't be blank"]
    end
  end

  context "email が指定されていないとき" do
    let(:user) { build(:user, email: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.messages[:email]).to eq ["can't be blank"]
    end
  end

  context "password が指定されていないとき" do
    let(:user) { build(:user, password: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.messages[:password]).to eq ["can't be blank"]
    end
  end

  context "すでに同じ名前の name が存在しているとき" do
    let(:user) { build(:user, name: "foo") }
    it "ユーザーの作成に失敗する" do
      create(:user, name: "foo")
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :taken
      expect(user.errors.details[:name][0][:value]).to eq "foo"
    end
  end

  context "ユーザーネームの最大文字数が31文字以上のとき" do
    let(:user) { build(:user, name: "a" * 31) }
    it "ユーザーの作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.messages[:name]).to eq ["is too long (maximum is 30 characters)"]
    end
  end
end

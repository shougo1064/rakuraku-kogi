require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "name, email, password が指定されているとき" do
      let(:params) { attributes_for(:user) }
      it "ユーザーの新規登録ができる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = JSON.parse(response.body)
        expect(res["data"]["name"]).to eq User.last.name
      end

      it "header 情報を取得することができる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["token-type"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["client"]).to be_present
      end
    end

    context "name が指定されていないとき" do
      let(:params) { attributes_for(:user, name: nil) }
      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]["name"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, email: nil) }
      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]["email"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }
      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]["password"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

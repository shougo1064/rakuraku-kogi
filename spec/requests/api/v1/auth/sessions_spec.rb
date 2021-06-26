require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "必要な情報が揃っているとき" do
      let(:params) { { email: user.email, password: user.password } }
      let!(:user) { create(:user) }
      it "ログインできる" do
        subject
        expect(response).to have_http_status(:ok)
        header = response.header
        expect(header["uid"]).to be_present
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
      end
    end

    context "email が間違っているとき" do
      let(:params) { attributes_for(:user, email: "test@example.com", password: user.password) }
      let!(:user) { create(:user) }
      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["uid"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
      end
    end

    context "password が間違っているとき" do
      let(:params) { attributes_for(:user, email: user.email, password: "aaaaaaaaaaa") }
      let!(:user) { create(:user) }
      it "エラーする" do
        subject
        header = response.header
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(:unauthorized)
        expect(header["uid"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "ログアウトに必要な情報を渡したとき" do
      let!(:headers) { user.create_new_auth_token }
      let(:user) { create(:user) }
      it "ログアウトできる" do
        expect { subject }.to change { user.reload.tokens }.from(be_present).to(be_blank)
        expect(response).to have_http_status(:ok)
      end
    end

    context "誤った情報を渡したとき" do
      let(:headers) { { "access-token" => "", "token-type" => "", "client" => "", "expiry" => "", "uid" => "" } }
      it "ログアウトできない" do
        subject
        expect(response).to have_http_status(:not_found)
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "User was not found or was not logged in."
      end
    end
  end
end

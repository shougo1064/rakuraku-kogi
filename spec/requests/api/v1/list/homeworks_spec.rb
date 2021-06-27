require "rails_helper"

RSpec.describe "Api::V1::List::Homeworks", type: :request do
  describe "GET /api/v1/list/homeworks" do
    subject { get(api_v1_list_homeworks_path) }

    let!(:homework1) { create(:homework, user: current_user, updated_at: 1.days.ago) }
    let!(:homework2) { create(:homework, user: current_user, updated_at: 3.days.ago) }
    let!(:homework3) { create(:homework, user: current_user) }
    let!(:homework4) { create(:homework) }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    it "課題の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "action", "deadline", "updated_at", "user"]
      expect(res.map {|d| d["id"] }).to eq [homework3.id, homework1.id, homework2]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      expect(res[0]["user"]["id"]).to eq current_user
    end
  end

  describe "GET /api/v1/list/homeworks/:id" do
    subject { get(api_v1_list_homework_path(homework_id)) }

    context "存在する自分の課題の id を指定したとき" do
      let(:homework_id) { homework.id }
      let(:homework) { create(:homework) }
      it "指定した id の課題の詳細が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq homework.id
        expect(res["title"]).to eq homework.title
        expect(res["body"]).to eq homework.body
        expect(res["action"]).to be_present
        expect(res["deadline"]).to be_present
        expect(res["updated_at"]).to be_present
        expect(res["user"].keys).to eq ["id", "name", "email"]
      end
    end

    context "存在しない課題の id を指定したとき" do
      let(:homework_id) { 100000 }
      it "課題の詳細が取得できない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST /api/v1/list/homeworks" do
    subject { post(api_v1_list_homeworks_path, params: params) }

    context "適切なパラメータを送信したとき" do
      let(:params) { { homework: attributes_for(:homework) } }
      let(:current_user) { create(:user) }
      before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

      it "課題の作成ができる" do
        expect { subject }.to change { Homework.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:homework][:title]
        expect(res["body"]).to eq params[:homework][:body]
        expect(res["action"]).to be_present
        expect(res["deadline"]).to be_present
        expect(res["user"]["id"]).to eq current_user.id
        expect(response).to have_http_status(:ok)
      end
    end

    context "不適切なパラメータを送信したとき" do
      let(:params) { attributes_for(:homework) }
      let(:current_user) { create(:user) }
      before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

      it "課題の作成に失敗する" do
        expect { subject }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "PUT /api/v1/list/homeworks/:id" do
    subject { put(api_v1_list_homework_path(homework.id), params: params) }

    let(:params) { { homework: { title: "foo", created_at: 1.days.ago } } }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    context "課題を更新するとき" do
      let!(:homework) { create(:homework, user: current_user) }
      it "適切な値のみ更新されている" do
        expect { subject }.to change { homework.reload.title }.from(homework.title).to(params[:homework][:title]) &
                              not_change { homework.reload.body } &
                              not_change { homework.reload.created_at }
      end
    end
  end

  describe "DELETE /api/v1/list/homeworks/:id" do
    subject { delete(api_v1_list_homework_path(homework.id)) }

    let!(:homework) { create(:homework, user: current_user) }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    it "記事が削除できる" do
      expect { subject }.to change { Homework.count }.by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end

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
    end
  end
end

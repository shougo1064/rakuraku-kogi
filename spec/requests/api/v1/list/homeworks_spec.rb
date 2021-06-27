require 'rails_helper'

RSpec.describe "Api::V1::List::Homeworks", type: :request do
  describe "GET /api/v1/list/homeworks" do
    subject { get(api_v1_list_homeworks_path)}
    let!(:homework1) { create(:homework), user: current_user, updated_at: }
    it "課題の一覧が取得できる" do

    end
  end
end

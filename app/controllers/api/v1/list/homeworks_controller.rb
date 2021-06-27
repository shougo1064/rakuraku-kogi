module Api::V1
  class List::HomeworksController < BaseApiController
    def index
      homeworks = current_user.homeworks.order(updated_at: :desc)
      render json: homeworks, each_serializer: Api::V1::HomeworkPreviewSerializer
    end
  end
end

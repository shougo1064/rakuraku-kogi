module Api::V1
  class List::HomeworksController < BaseApiController
    def index
      homeworks = current_user.homeworks.order(updated_at: :desc)
      render json: homeworks, each_serializer: Api::V1::HomeworkPreviewSerializer
    end

    def show
      homework = Homework.find(params[:id])
      render json: homework, serializer: Api::V1::HomeworkSerializer
    end
  end
end

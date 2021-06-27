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

    def create
      homework = current_user.homeworks.create!(homework_params)
      render json: homework, serializer: Api::V1::HomeworkSerializer
    end

    def update
      homework = current_user.homeworks.find(params[:id])
      homework.update!(homework_params)
      render json: homework, serializer: Api::V1::HomeworkSerializer
    end

    def destroy
      homework = current_user.homeworks.find(params[:id])
      homework.destroy!
    end

    private

      def homework_params
        params.require(:homework).permit(:title, :body, :action, :deadline)
      end
  end
end

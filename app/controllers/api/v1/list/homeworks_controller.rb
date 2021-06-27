module Api::V1
  class List::HomeworksController < BaseApiController
		def index
			homeworks = current_user.homeworks.order(action: :desc)
			render json: homeworks, each_serializer: APi::V1::HomeworkPreviewSerializer
		end
  end
end

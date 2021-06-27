class Api::V1::HomeworkPreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :action, :deadline, :updated_at
  belongs_to :user, serializer: Api::V1::UserSerializer
end

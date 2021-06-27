class Api::V1::HomeworkSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :action, :deadline, :updated_at
  belongs_to :user, serializer: Api::V1::UserSerializer
end

class QuestionEditSerializer < ActiveModel::Serializer
  attributes :body

  has_one :user, serializer: UserPreviewSerializer , key: :editor
end

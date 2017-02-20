class FavouriteSerializer < ActiveModel::Serializer
  has_one :question, serializer: QuestionPreviewSerializer
end

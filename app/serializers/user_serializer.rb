class UserSerializer < ActiveModel::Serializer
  attributes :username , :email 

  has_many :questions, serializer: QuestionPreviewSerializer
  has_many :favourites

end

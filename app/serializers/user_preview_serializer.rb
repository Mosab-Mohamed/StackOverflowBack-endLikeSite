class UserPreviewSerializer < ActiveModel::Serializer
  attributes :id , :username , :email 

  # url [:question, :answers , :user]
  
end

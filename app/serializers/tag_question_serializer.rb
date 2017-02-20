class TagQuestionSerializer  < ActiveModel::Serializer
  attributes :id , :question_id , :tag_name
  def tag_name
    object.tag.name
  end
end

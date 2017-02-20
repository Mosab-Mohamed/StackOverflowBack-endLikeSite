class AnswerEditSerializer < ActiveModel::Serializer
  attribute :body
  attribute :editor

  def editor
    editor_user = Hash.new

    editor_user["username"] = object.user.username
    editor_user["email"] = object.user.email

    return editor_user
  end
end

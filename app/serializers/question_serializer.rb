class QuestionSerializer < ActiveModel::Serializer
  attributes :title , :body , :status , :views , :votes

  has_one :user, serializer: UserPreviewSerializer , key: :inquirer
  has_many :comments
  has_many :answers
  has_many :question_edits , key: :edits
  has_many :tag_questions , serializer: TagQuestionSerializer

  def votes
    votes = Hash.new

    votes["up"] = Vote.votes_up(object.id , "Question")
    votes["down"] = Vote.votes_down(object.id , "Question")

    return votes
  end

  # url :question
  
end

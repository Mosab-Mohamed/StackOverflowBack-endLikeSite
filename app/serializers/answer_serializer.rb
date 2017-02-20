class AnswerSerializer < ActiveModel::Serializer
  attributes :body , :verified , :votes

  has_one :user, serializer: UserPreviewSerializer #, key: :respondent
  has_many :comments , key: :replies
  has_many :answer_edits , key: :edits

  def votes
    votes = Hash.new

    votes["up"] = Vote.votes_up(object.id , "Answer")
    votes["down"] = Vote.votes_down(object.id , "Answer")

    return votes
  end

  # url [:question, :answers]
end

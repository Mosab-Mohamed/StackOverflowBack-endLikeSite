class CommentSerializer < ActiveModel::Serializer
  attributes :body , :votes , :id
  attribute :user_id , key: :commenter_id 

  has_one :user, serializer: UserPreviewSerializer , key: :commenter

  def votes
    votes = Hash.new

    votes["up"] = Vote.votes_up(object.id , "Comment")
    votes["down"] = Vote.votes_down(object.id , "Comment")

    return votes
  end

  # url [:commentable_type, :comments]
end

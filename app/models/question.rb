class Question < ActiveRecord::Base

	include ActiveModel::Serialization

	 has_many :answers
	 has_many :comments , :as => :commentable
	 has_many :votes, :as => :votable
	 has_many :question_edits
	 has_many :favourites
	 has_many :tag_questions

	 belongs_to :user

	 validates :title, presence: true
  	 validates :body, presence: true

	 scope :newest_questions, lambda {
	 	order("questions.created_at DESC")
	 }

	 scope :un_fetched_questions, lambda {|question_id|
	 	where("questions.id > ?",question_id)
	 }

	 scope :highest_views, lambda {
	 	order("questions.views DESC")
	 }

end

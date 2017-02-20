class Answer < ActiveRecord::Base

	has_many :votes, :as => :votable
	has_many :comments , :as => :commentable
	has_many :answer_edits

	belongs_to :user
	belongs_to :question

	validates :body, presence: true
end

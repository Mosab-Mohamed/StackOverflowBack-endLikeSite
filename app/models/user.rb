class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :question_edits
  has_many :answer_edits
  has_many :favourites


  after_create :update_access_token!  

  validates :username, presence: true
  validates :email, presence: true
  validates :access_token, uniqueness: true

  private

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  
end

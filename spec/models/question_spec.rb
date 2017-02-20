require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.build(:question) }

  subject { @question }

 
  #here we test the presence of email for user model using ordianry RSpec
  # describe "when email is not present" do
	 #  before { @user.email = " " }
	 #  # the previouse statement shouldn't happen
	 #  it { should_not be_valid }
	# end

	#and here we test using shoulda-matchers
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:body) }

  it { should be_valid }
end

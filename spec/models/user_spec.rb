require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

 
  #here we test the presence of email for user model using ordianry RSpec
  # describe "when email is not present" do
	 #  before { @user.email = " " }
	 #  # the previouse statement shouldn't happen
	 #  it { should_not be_valid }
	# end

	#and here we test using shoulda-matchers
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should respond_to(:access_token) }
	it { should validate_uniqueness_of(:access_token)}
	it { should allow_value('example@domain.com').for(:email) }

  it { should be_valid }
end

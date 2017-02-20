require 'spec_helper'

describe Answer do
  before { @answer = FactoryGirl.build(:answer) }

  subject { @answer }

	it { should validate_presence_of(:body) }

  it { should be_valid }
end

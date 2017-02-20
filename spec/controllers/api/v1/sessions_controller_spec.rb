require 'spec_helper'

describe Api::V1::SessionsController do

	describe "POST #create" do

	    before(:each) do
	    	@user = FactoryGirl.create :user
	   	end

	    context "when the credentials are correct" do

	      before(:each) do
	        credentials = { username: @user.email, password: "12345678" }
	        post :create, credentials
	      end

	      it "returns the user record corresponding to the given credentials" do
	        @user.reload
	        expect(json_response[:access_token]).to eql @user.access_token
	      end

	      it { should respond_with 200 }
	    end

	    context "when the credentials are incorrect" do

	      before(:each) do
	        credentials = { username: @user.email, password: "invalidpassword" }
	        post :create, credentials
	      end

	      it "returns a json with an error" do
	        expect(json_response[:errors]).to eql "Invalid email or password"
	      end

	      it { should respond_with :unprocessable_entity }
	    end
	end



	describe "DELETE #destroy" do

	    before(:each) do
	      @user = FactoryGirl.create :user
	      # sign_in @user, store: false
	      api_authorization_header @user.access_token #we added this line
	      delete :destroy
	    end

	    it { should respond_with 204 }

 	 end
end
require 'spec_helper'

describe Api::V1::AnswersController do



  	describe "POST #create" do

  		#right request
	    context "when is successfully created" do

	      before(:each) do
	      	@user = FactoryGirl.create :user
	        api_authorization_header @user.access_token #we added this line
	        @question = FactoryGirl.create :question
	        @answer_attributes = FactoryGirl.attributes_for :answer
	        @answer_attributes[:question_id] = @question.id
	        post :create, { answer: @answer_attributes }, format: :json
	      end

	      it "renders the json representation for the user record just created" do
	        answer_response = json_response
	        expect(answer_response[:question][:answers][0][:body]).to eql @answer_attributes[:body]
	      end

	      it { should respond_with 201 }
	    end

  	end




  	describe "PUT/PATCH #update" do

	    context "when is successfully updated" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create :question
	        @answer = FactoryGirl.create(:answer, question_id: @question.id , user_id: @user.id)
	        patch :update, { id: @answer.id,
	                         answer: { body: "new body" } }, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        answer_response = json_response
	        expect(answer_response[:question][:answers][0][:body]).to eql "new body"
	      end

	      it { should respond_with 201 }
	    end

	    context "when is not created" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create :question
	        @answer = FactoryGirl.create(:answer, question_id: @question.id)
	        patch :update, { id: @answer.id,
	                         answer: { body: "" } }, format: :json
	      end

	      it "renders an errors json" do
	        question_response = json_response
	        expect(question_response).to have_key(:errors)
	      end

	      it { should respond_with 422 }
	    end
  	end



  	describe "DELETE #destroy" do
	    before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @answer = FactoryGirl.create(:answer, user_id: @user.id)
	        delete :destroy, id: @answer.id
	    end

	    it { should respond_with 204 }

  	end


  	describe "PUT/PATCH #verify" do

	    context "when is successfully updated" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create(:question, user_id: @user.id)
	        @answer = FactoryGirl.create(:answer, question_id: @question.id)
	        patch :verify, { id: @answer.id}, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        question_response = json_response
	        expect(question_response[:question][:answers][0][:verified]).to eql true
	      end

	      it { should respond_with 201 }
	    end
	    
  	end



end

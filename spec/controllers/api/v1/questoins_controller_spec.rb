require 'spec_helper'

describe Api::V1::QuestionsController do
	
	

	describe "GET #show_question" do
    	before(:each) do
      		@question = FactoryGirl.create :question
      		get :show_question, id: @question.id, format: :json
    	end

    	it "returns the information about a reporter on a hash" do
      		question_response = json_response
      		expect(question_response[:question][:title]).to eql @question.title
    	end

    	it { should respond_with 200 }
  	end




  	describe "POST #create" do

  		#right request
	    context "when is successfully created" do

	      before(:each) do
	      	@user = FactoryGirl.create :user
	        api_authorization_header @user.access_token #we added this line
	        @question_attributes = FactoryGirl.attributes_for :question
	        @question_attributes[:user_id] = @user.id
	        post :create, { question: @question_attributes }, format: :json
	      end

	      it "renders the json representation for the user record just created" do
	        question_response = json_response
	        expect(question_response[:question_preview][:title]).to eql @question_attributes[:title]
	      end

	      it { should respond_with 201 }
	    end

  	end




  	describe "PUT/PATCH #update" do

	    context "when is successfully updated" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create(:question, user_id: @user.id)
	        patch :update, { id: @question.id,
	                         question: { title: "new title" } }, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        question_response = json_response
	        expect(question_response[:question][:title]).to eql "new title"
	      end

	      it { should respond_with 200 }
	    end

	    context "when is not created" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token #we added this line
	        @question = FactoryGirl.create :question
	        @question.user_id = @user.id
	        patch :update, { id: @question.id,
	                         question: { title: "" } }, format: :json
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
	        @question = FactoryGirl.create(:question, user_id: @user.id)
	        delete :destroy, id: @question.id
	    end

	    it { should respond_with 204 }

  	end


  	describe "PUT/PATCH #set_resolved" do

	    context "when is successfully updated" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create(:question, user_id: @user.id)
	        patch :set_resolved, { id: @question.id}, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        question_response = json_response
	        expect(question_response[:question][:status]).to eql "resolved"
	      end

	      it { should respond_with 200 }
	    end
	    
  	end



end

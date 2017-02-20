require 'spec_helper'

describe Api::V1::CommentsController do



  	describe "POST #create" do

  		#right request
	    context "when is successfully created" do

	      before(:each) do
	      	@user = FactoryGirl.create :user
	        api_authorization_header @user.access_token #we added this line
	        @question = FactoryGirl.create :question
	        @comment_attributes = FactoryGirl.attributes_for :comment
	        @comment_attributes[:commentable_id] = @question.id
	        @comment_attributes[:commentable_type] = "question"
	        post :create, { comment: @comment_attributes }, format: :json
	      end

	      it "renders the json representation for the user record just created" do
	        comment_response = json_response
	        expect(comment_response[:comment][:body]).to eql @comment_attributes[:body]
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
	        @comment = FactoryGirl.create(:comment, commentable_id: @question.id ,
	        				 commentable_type: "question" , user_id: @user.id)
	        patch :update, { id: @comment.id,
	                         comment: { body: "new body" } }, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        comment_response = json_response
	        expect(comment_response[:comment][:body]).to eql "new body"
	      end

	      it { should respond_with 200 }
	    end

	    context "when is not created" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create :question
	        @comment = FactoryGirl.create(:comment, commentable_id: @question.id ,
	        				 commentable_type: "question" )
	        patch :update, { id: @comment.id,
	                         comment: { body: "" } }, format: :json
	      end

	      it "renders an errors json" do
	        comment_response = json_response
	        expect(comment_response).to have_key(:errors)
	      end

	      it { should respond_with 422 }
	    end
  	end



  	describe "DELETE #destroy" do
	    before(:each) do
	        @user = FactoryGirl.create :user
	        api_authorization_header @user.access_token
	        @question = FactoryGirl.create :question
	        @comment = FactoryGirl.create(:comment, commentable_id: @question.id ,
	        				 commentable_type: "question" , user_id: @user.id)
	        delete :destroy, id: @comment.id
	    end

	    it { should respond_with 204 }

  	end



end

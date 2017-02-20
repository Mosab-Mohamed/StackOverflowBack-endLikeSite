class Api::V1::QuestionsController < ApplicationController

	skip_before_action :authenticate_user_from_token!, only: [:show_question , :index , :search]

	def show_question
	   question = Question.find(params[:id])
	   question.update_attribute(:views , (question.views+1))
	   render json: question, include: { inquirer:[] , comments:[:commenter], answers:[:edits] , edits:[:editor] , tag_questions:[]}
	end

	def index
		# @questions = Question.un_fetched_questions(params[:last_id]).newest_questions.highest_views.limit(20)
		@questions = Question.all
		# render :json => @questions, :each_serializer => :QuestionPreviewSerializer
		render json: @questions , each_serializer: QuestionPreviewSerializer #, include: { inquirer:[] , comments:[:commenter], answers:[:edits] , edits:[:editor] , tags:[:tag]}
	
	end

	def create
	   question=Question.new(question_params) 
	   question.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if question.save 
	    	render json: question, serializer: QuestionPreviewSerializer  , status: 201
	    else
	    	render json: { errors: question.errors}, status: 422
	   end
	end

	def update
		question = Question.find(params[:id])
		if(current_user.id == question.user_id)
	    	if question.update(question_params)
		      render json: question, status: 200
		    else
		      render json: { errors: question.errors }, status: 422
		    end
	    else
	    	render json: { errors: "can't update question belongs to another user" }, status: 422
	    end
	end

	# Deleting question
	def destroy
	    question = Question.find(params[:id])
	    if(current_user.id == question.user_id)
			question.destroy
			head 204
		else
			render json: { errors: "can't delete question belongs to another user" }, status: 422
	    end
	    
	end

	def search

		if(params[:type]=="")
			 @questions = Question.where(["title LIKE ?","%#{params[:query]}%"])
			 render json: @questions , each_serializer: QuestionPreviewSerializer

		elsif (params[:type]=="tag")
			if(params[:query]!="")
				tag_ids = Tag.select(:id).where("tags.name > ?" , params[:query])
				question_ids = TagQuestion.select(:question_id).where("tag_questions.tag_id in ?",tag_ids)
				@questions = Question.where("questions.id" , question_ids)
				render json: @questions , each_serializer: QuestionPreviewSerializer
			end
			
		elsif (params[:type]=="top_views")
			@questions = Question.order("questions.views DESC")
			render json: @questions , each_serializer: QuestionPreviewSerializer

		elsif (params[:type]=="newest")
			@questions = Question.order("questions.created_at DESC")
			render json: @questions , each_serializer: QuestionPreviewSerializer
		
		else
			render json: { errors: "invalid search parameters" }, status: 401
		end
				
	end

	def set_resolved
		question = Question.find(params[:id])
		if(current_user.id == question.user_id)
			question.update_attribute(:status ,"resolved")
			render json: question, status: 200
		else
	    	render json: { errors: "can't update question belongs to another user" }, status: 422
	    end
	end

	private

	  def question_params
	  	params.require(:question).permit(:title, :body) 
	  end
end
class Api::V1::TagQuestionsController < ApplicationController

	def create
		tags = params[:tags][:tag_ids]

		tags.each do |tag|
			Rails.logger = Logger.new(STDOUT)
		logger.debug "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"
			logger.debug tag
		   tag_question=TagQuestion.new(:tag_id => tag.to_i , :question_id => params[:question_id].to_i)

		   	if !(tag_question.save) 
				render json: { errors: tag.errors}, status: 422
			end
		end
		# question = Question.find(params[:question_id].to_i)
	 #    render json: question , status: 201
	end

	def index
		render json: TagQuestion.all
		
	end

	# Deleting 
	def destroy
	    tag_question = TagQuestion.find(params[:id])
	    user_id = Question.find(params[:question_id]).user_id
	    if(current_user.id == user_id)
			tag_question.destroy
			head 204
		else
			render json: { errors: "can't delete edit tags belongs to another user's question" }, status: 422
	    end
	    
	end


	def show_tagged_questions
	    tag_question = TagQuestion.find(params[:id])
	    user_id = Question.find(params[:question_id]).user_id
	    if(current_user.id == user_id)
			tag_question.destroy
			head 204
		else
			render json: { errors: "can't delete edit tags belongs to another user's question" }, status: 422
	    end
	    
	end

	private

	  def tag_params
	  	params.require(:tags).permit(:question_id, :tag_ids => []) 
	  end
end

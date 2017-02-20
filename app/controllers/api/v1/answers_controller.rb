class Api::V1::AnswersController < ApplicationController

	def create
	   answer=Answer.new(answer_params) 
	   answer.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if answer.save 
			question = Question.find(answer.question_id)
	    	render json: question, status: 201
	    else
	    	render json: { errors: answer.errors}, status: 422
	   end
	end


	# Deleting answer
	def destroy
	    answer = Answer.find(params[:id])
	    if(current_user.id == answer.user_id)
			answer.destroy
			head 204
		else
			render json: { errors: "can't delete answer belongs to another user" }, status: 422
	    end
	    
	end

	def update
		answer = Answer.find(params[:id])
		if(current_user.id == answer.user_id)
	    	if answer.update(answer_params)
		    	question = Question.find(answer.question_id)
	    		render json: question, status: 201
		    else
		      render json: { errors: answer.errors }, status: 422
		    end
	    else
	    	render json: { errors: "can't update answer belongs to another user" }, status: 422
	    end
	end

	def verify
		answer = Answer.find(params[:id])
		question = Question.find(answer.question_id)
		if(current_user.id == question.user_id)
			answer.update_attribute(:verified, true)
			render json: question, status: 201
		end
	end

	private

	  def answer_params
	  	params.require(:answer).permit(:question_id , :body) 
	  end

end

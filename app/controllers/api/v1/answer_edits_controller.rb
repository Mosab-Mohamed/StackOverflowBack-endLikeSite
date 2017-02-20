class Api::V1::AnswerEditsController < ApplicationController

	def create
	   answer_edit=AnswerEdit.new(answer_edit_params) 
	   answer_edit.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if answer_edit.save 
			question_id = Answer.find(answer_edit.answer_id).question_id
			question = Question.find(question_id)
	    	render json: question, status: 201
	    else
	    	render json: { errors: answer.errors}, status: 422
	   end
	end


	# Deleting answer
	def destroy
	    answer_edit = AnswerEdit.find(params[:id])
	    if(current_user.id == answer_edit.user_id)
			answer_edit.destroy!
			head 204
		else
			render json: { errors: "can't delete edit belongs to another user" }, status: 422
	    end
	    
	end

	def update
		answer_edit = AnswerEdit.find(params[:id])
		if(current_user.id == answer_edit.user_id)
	    	if answer_edit.update(answer_edit_params)
		    	question_id = Answer.find(answer_edit.answer_id).question_id
				question = Question.find(question_id)
	    		render json: question, status: 201
		    else
		      render json: { errors: answer.errors }, status: 422
		    end
	    else
	    	render json: { errors: "can't update edit belongs to another user" }, status: 422
	    end
	end



	private

	  def answer_edit_params
	  	params.require(:answer_edit).permit(:answer_id , :body) 
	  end
end

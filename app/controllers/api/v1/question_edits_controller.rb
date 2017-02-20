class Api::V1::QuestionEditsController < ApplicationController

	def create
	   question_edit=QuestionEdit.new(question_edit_params) 
	   question_edit.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if question_edit.save
			question = Question.find(question_edit.question_id)
	    	render json: question , status: 201
	    else
	    	render json: { errors: question_edit.errors}, status: 422
	   end
	end

	def update
		question_edit = QuestionEdit.find(params[:id])
		if(current_user.id == question_edit.user_id)
	    	if question_edit.update(question_edit_params)
	    		question = Question.find(question_edit.question_id)
		      	render json: question, status: 200
		    else
		      render json: { errors: question_edit.errors }, status: 422
		    end
	    else
	    	render json: { errors: "can't update edits belongs to another user" }, status: 422
	    end
	end

	# Deleting question
	def destroy
	    question_edit = QuestionEdit.find(params[:id])
	    if(current_user.id == question_edit.user_id)
			question_edit.destroy
			head 204
		else
			render json: { errors: "can't edits question belongs to another user" }, status: 422
	    end
	    
	end

	private

	  def question_edit_params
	  	params.require(:question_edit).permit(:question_id, :body) 
	  end
end

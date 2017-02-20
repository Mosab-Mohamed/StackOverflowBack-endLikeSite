class Api::V1::CommentsController < ApplicationController

	skip_before_action :authenticate_user_from_token!, only: [:show]

	def show
		render json: Comment.find(params[:id])
	end


	def create
	   comment=Comment.new(comment_params) 
	   comment.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if comment.save 
	    	render json: comment  , status: 201
	    else
	    	render json: { errors: comment.errors}, status: 422
	   end
	end

	def update
		comment = Comment.find(params[:id])
		if(current_user.id == comment.user_id)
	    	if comment.update(comment_params)
		      render json: comment, status: 200
		    else
		      render json: { errors: comment.errors }, status: 422
		    end
	    else
	    	render json: { errors: "can't update comment belongs to another user" }, status: 422
	    end
	end

	# Deleting question
	def destroy
	    comment = Comment.find(params[:id])
	    if(current_user.id == comment.user_id)
			comment.destroy
			head 204
		else
			render json: { errors: "can't delete comment belongs to another user" }, status: 422
	    end
	    
	end


	private

	def get_parameters

		@commentable_type = find_commentable
		if params[:commentable_id] && @commentable!=nil
			@commentable = @commentable_type.find(params[:commentable_id])
		end
	end

	def find_commentable
		params.each do |name,value|
			if name!="user_id" && name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
		nil
	end

	def comment_params
		params.require(:comment).permit(:commentable_id , :commentable_type , :body) 
	end


end

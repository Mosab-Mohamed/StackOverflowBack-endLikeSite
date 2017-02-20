class Api::V1::FavouritesController < ApplicationController

	def create
	   favourite=Favourite.new(favourite_params) 
	   favourite.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if favourite.save
	    	render json: current_user  , status: 201
	    else
	    	render json: { errors: favourite.errors}, status: 422
	   end
	end

	# Deleting question
	def destroy
	    favourite = Favourite.find(params[:id])
	    if(current_user.id == favourite.user_id)
			favourite.destroy
			head 204
		else
			render json: { errors: "can't delete favourite belongs to another user" }, status: 422
	    end
	    
	end


	private

	  def favourite_params
	  	params.require(:favourite).permit(:question_id) 
	  end
end

class Api::V1::TagsController < ApplicationController

	def create
		@tag = Tag.new tag_params
		
		if @tag.save
	      render json: @tag
	    else
	      render json: { errors: @tag.errors }, status: :unprocessable_entity
	    end
	end

	
	private

	  def tag_params
	  	params.require(:tag).permit(:name, :description) 
	  end
end

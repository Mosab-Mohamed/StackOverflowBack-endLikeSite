class Api::V1::VotesController < ApplicationController

	before_action :check_previous_vote

	# def index
	# 	votes = Vote.all
	# 	render json: votes
		
	# end

	def create
		vote = Vote.new(vote_params) 
		vote.user_id = current_user.id
		# if the user is saved successfully than respond with json data and status code 201
		if vote.save 
	    	head 201
	    else
	    	render json: { errors: tag.errors}, status: 422
	   end
	end

	# def destroyall
	# 	votes = Vote.all
	# 	votes.each do |vote|
	# 		vote.destroy
	# 	end
		
	# end

	private

	  def vote_params
	  	params.require(:vote).permit(:votable_id, :votable_type , :up_or_down) 
	  end

	  def check_previous_vote
	  	vote_params
	  	vote = Vote.where("votes.user_id = ? And votes.votable_type = ? And votes.votable_id = ? " ,current_user.id.to_s , params[:vote][:votable_type] , params[:vote][:votable_id] ).first

	  	if vote
	  		if ( (vote.up_or_down && params[:vote][:up_or_down]) || (vote.up_or_down==false && params[:vote][:up_or_down]==false) )

	  			render json: { errors: "can't vote twice on the same question" }, status: 422
	  		else
	  			vote.destroy
	  			head 204
	  		end
	  	end
	  end
end

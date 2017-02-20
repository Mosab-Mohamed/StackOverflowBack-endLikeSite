class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create , :show , :search]

  # POST /v1/users
  # Creates an user
  def create
    @user = User.new user_params

    if @user.save
      render json: @user, serializer: SessionSerializer, root: nil
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find(params[:id])
  	# if(current_user!=nil)
  	# 	render json: current_user
  	# else
  	# 	render json: {error: 'user must login'}, status: :unprocessable_entity
  	# end
  	
  end

  def update
    if(current_user.id == params[:id].to_i)
      user = User.find(params[:id].to_i)
      if user.update(user_params)
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    else
      render json: { errors: "can't update other's information" }, status: 422
    end
  end

  def destroy
    if(current_user.id == params[:id].to_i)
        user = User.find(params[:id])
      user.destroy
      head 204
    else
      render json: { errors: "can't delete other's accounts" }, status: 422
    end
  end


  def search

    if(params[:type]=="username")
       @users = User.where(["username LIKE ?","%#{params[:query]}%"])
       render json: @users , each_serializer: UserPreviewSerializer

    elsif (params[:type]=="email")
        @user = User.where("users.email > ?" , params[:query])
        render json: @user
    
    else
      render json: { errors: "invalid search parameters" }, status: 401
    end
        
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
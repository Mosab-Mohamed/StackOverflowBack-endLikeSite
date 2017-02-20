class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create, :show]

  # POST /v1/login
  def create
    @user = User.find_for_database_authentication(email: params[:username])
    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render json: @user, serializer: SessionSerializer, root: nil
    else
      invalid_login_attempt
    end
  end

  # DELETE /v1/logout
  def destroy
    sign_out current_user
    render json: {action: 'successful logout'}, status: 204
  end

  private

  def invalid_login_attempt
    warden.custom_failure!
    render json: {errors: "Invalid email or password"}, status: :unprocessable_entity
  end

      
end
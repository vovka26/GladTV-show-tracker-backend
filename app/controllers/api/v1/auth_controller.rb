class Api::V1::AuthController < ApplicationController
  def create # POST /api/v1/login
    byebug
    @user = User.find_by(username: params[:username])
    # byebug
    if @user && @user.authenticate(params[:password])
      render json: {
          message: 'logged in',
          error: false,
          success: true,
          userData: @user,
          token: encode({user_id: @user.id})
          }, status: :accepted
    else
      render json: {
          message: 'error',
          error: true
          }, status: :unauthorized
    end
  end
end

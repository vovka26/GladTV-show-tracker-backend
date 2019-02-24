class Api::V1::UsersController < ApplicationController
  def profile
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)
    
    @user = User.find(payload['user_id'])

    render json: {
      userData: @user,
      success: true,
      error: false
    }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: {
        message: 'created',
        success: true,
        error: false,
        userData: @user,
        token: encode({ user_id: @user.id })
      }, status: :created
    else
      rend
      er json: {
        error: @user.errors.full_messages },
        status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end

end

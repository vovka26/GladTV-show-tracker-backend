class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:profile, :user_shows]

  def profile
    render json: {
      userData: @user,
      success: true,
      error: false
    }, status: :accepted
  end

  def user_shows
    render json: @user.shows
  end

  def create
    byebug
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
      render json: {
        error: @user.errors.full_messages },
        status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end

  def find_user
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)

    @user = User.find(payload['user_id'])
  end

end

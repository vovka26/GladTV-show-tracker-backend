class Api::V1::ShowsController < ApplicationController
  before_action :set_show, only: [:delete_from_users_watchlist]
  before_action :set_user, only: [:create, :index, :delete_from_users_watchlist]

  def index
    @shows = @user.shows
    render json: @shows
  end


  # checks if the show is already in DB. if it is, only adds show to user's watchlist array.
  # if the show is not in DB, it creates a record and adds to watchlist
  def create
    @show = Show.where(show_params).first_or_create do |show|
      show.title = show_params[:title]
      show.rating = show_params[:rating]
      show.genre = show_params[:genre]
      show.image_url = show_params[:image_url]
      show.api_id = show_params[:api_id]
    end

      if !@user.shows.include?(@show)
        @user.shows << @show
        render json: {
          message: 'added',
          success: true,
          error: false,
          showData: @show
        }

      elsif @user.shows.include?(@show)
        render json: {
          message: 'movie is already in the list',
          success: false,
          error: true
        }
      else
        render json: {
          message: 'show is not valid',
          success: false,
          error: @show.errors.full_messages
        }
      end
  end

  # deletes show from the user's watchlist
  def delete_from_users_watchlist
    if @user.shows.include?(@show)
      deleted_show = @user.shows.delete(@show)
    end
    if deleted_show
      render json: {
        message: 'show has been deleted',
        success: true,
        error: false,
        showData: deleted_show
      }
    else
      render json: {
        message: 'user doesnt follow this show',
        success: false,
        error: true
      }
    end

  end

  def find_shows
    response = get_info_from_api(url_to_search)
    render json: response
  end

  def show_details
    response = get_info_from_api(url_to_show_details)
    render json: response
  end

  def get_info_from_api(url)
    response = RestClient.get(url).body
    json_response = JSON.parse(response)
  end

  def url_to_search
    query = params[:query]

    if params[:page] == nil
      page = '1'
    else
      page = params[:page]
    end

    'https://api.themoviedb.org/3/search/tv?api_key='+api_key+'&language=en-US&query='+query+'&page='+page
  end

  def url_to_show_details
    id = params[:id]

    'https://api.themoviedb.org/3/tv/'+id+'?api_key='+api_key+'&language=en-US'
  end

  private

  def api_key
    key = Rails.application.credentials.development[:movies_secret_key_base]
  end

  def show_params
    params.require(:show).permit(:title, :rating, :genre, :image_url, :api_id)
  end

  def set_show
    @show = Show.find(params[:id])
  end

  def set_user
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload['user_id'])
  end

end

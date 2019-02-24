class Api::V1::ShowsController < ApplicationController
  before_action :set_show, only: [:show, :destroy]
  before_action :find_user, only: [:create]

  def index
    @shows = Show.all
    render json: @shows
  end

  def show

  end

  def create
    # @show = Show.where(show_params).first_or_create do |show|
    #   show.title = show_params
    # end
    @show = Show.create(show_params)
    if @show.valid?
      @user.shows << @show
      render json: {
        message: 'added',
        success: true,
        error: false,
        showData: @show
      }
    end
  end

  # t.string "title"
  # t.integer "rating"
  # t.string "genre"
  # t.string "image_url"
  # t.integer "api_id"

  def destroy

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

  def find_user
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload['user_id'])
  end

end

class Api::V1::ShowsController < ApplicationController

  def index
    response = get_info_from_api(url_to_search)
    render json: response
  end

  def show
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

end

class Api::V1::SeasonsController < ApplicationController

  # def index
  #
  #   response = url_to_season_details
  #   render json: response
  # end

  def all_seasons

  end

  def season_data
    response = get_info_from_api(url_to_season_details)
    render json: response
  end

  def get_info_from_api(url)
    response = RestClient.get(url).body
    json_response = JSON.parse(response)
  end

  def url_to_season_details
    showId = params[:showId]
    seasonId = params[:seasonId]

    'https://api.themoviedb.org/3/tv/'+showId+'/season/'+seasonId+'?api_key='+api_key+'&language=en-US'
  end

end

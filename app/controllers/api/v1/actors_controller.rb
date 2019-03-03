class Api::V1::ActorsController < ApplicationController

  def show
    response = get_actor_data(url_to_search)
    render json: response
  end

  def url_to_search
    actor_id = params[:id]

    'https://api.themoviedb.org/3/person/'+actor_id+'?api_key='+api_key+'&language=en-US&append_to_response=tv_credits'
  end

  def get_actor_data(url)
    response = RestClient.get(url).body
    json_response = JSON.parse(response)
  end

end

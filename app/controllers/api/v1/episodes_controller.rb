class Api::V1::EpisodesController < ApplicationController
  before_action :set_user, only: [:index, :create, :delete_from_users_watchlist, :get_episodes_for_season]
  before_action :set_show, only: [:get_episodes_for_season]
  before_action :set_episode, only: [:delete_from_users_watchlist]

  def index
    # shows = @user.episodes
    # render json: shows
  end

  def create
    byebug
    @season = Season.find_or_create_by(api_id: episode_params[:season_id])
    @show = Show.find_by(api_id: params[:show_id])

    @episode = Episode.where(episode_params).first_or_create do |episode|
      episode.title = episode_params[:title]
      episode.air_date = episode_params[:air_date]
      episode.image_url = episode_params[:image_url]
      episode.api_id = episode_params[:api_id]
      episode.show_id = @show.id
      episode.season_id = episode_params[:season_id]
    end

    @user.episodes << @episode

    render json: {
      message: 'added',
      success: true,
      error: false,
      episodeData: @episode
    }
  end

  def get_episodes_for_season
    byebug
    show_episodes = @user.episodes.find_all {|ep| ep.show_id == @show.id}
    byebug
    season_episodes = show_episodes.find_all {|ep| ep.season_id == params[:season_id].to_i}
    render json: {
      success: true,
      error: false,
      episodes: season_episodes
    }
  end

  def delete_from_users_watchlist
    byebug
    if @user.episodes.include?(@episode)
      deleted_episode = @user.episodes.delete(@episode)
    end
    if deleted_episode
      render json: {
        message: 'episode has been deleted',
        success: true,
        error: false,
        episodeData: deleted_episode
      }
    else
      render json: {
        message: 'user doesnt follow this episode',
        success: false,
        error: true
      }
    end
  end

  private

  def api_key
    key = Rails.application.credentials.development[:movies_secret_key_base]
  end

  def episode_params
    params.require(:episode).permit(:title, :image_url, :air_date, :api_id, :show_id, :season_id)
  end

  def set_show
    @show = Show.find_by(api_id: params[:show_id])
  end

  def set_season
    @season = Season.find_by()
  end

  def set_episode
    @episode = Episode.find_by(api_id: params[:id])
  end

  def set_user
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload['user_id'])
  end
end

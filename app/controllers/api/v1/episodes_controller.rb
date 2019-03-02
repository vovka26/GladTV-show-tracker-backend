class Api::V1::EpisodesController < ApplicationController
  before_action :set_user, only: [:create, :delete_from_users_watchlist, :get_episodes_for_season]
  before_action :set_show, only: [:get_episodes_for_season, :create]
  before_action :set_season, only: [:create]

  def index
    render json: Episode.all
  end

  def create
    @episode = Episode.find_by(api_id: params[:api_id])
    if @episode
      @episode
    else
      @episode = Episode.where(episode_params).first_or_create do |episode|
        episode.title = episode_params[:title]
        episode.air_date = episode_params[:air_date]
        episode.image_url = episode_params[:image_url]
        episode.api_id = episode_params[:api_id]
        episode.show_id = @show.id
        episode.season_id = @season.id
      end
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
    if @show
      show_episodes = @user.episodes.find_all {|ep| ep.show_id == @show.id}
      render json: {
        success: true,
        error: false,
        episodes: show_episodes
      }
    else
      render json: {
        success: false,
        error: true
      }
    end

  end

  def delete_from_users_watchlist
    @episode = Episode.find_by(api_id: params[:id])
    if ep = @user.episodes.find {|ep| ep.api_id == @episode.api_id}
      deleted_episode = @user.episodes.delete(ep)
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
        message: 'user didnt watch this episode',
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
    @season = Season.find_or_create_by(api_id: params[:season_id])
  end

  def set_user
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload['user_id'])
  end
end

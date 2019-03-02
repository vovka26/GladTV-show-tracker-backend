Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :shows, only: [:index, :create]
      resources :episodes, only: [:index, :create]

      get '/shows/:show_id/episodes', to: 'episodes#get_episodes_for_season'

      delete '/shows/:id', to: 'shows#delete_from_users_watchlist'

      delete '/episodes/:id', to: 'episodes#delete_from_users_watchlist'

      # delete '/shows/episodes/:id', to: 'episodes#delete_from_users_watchlist'

      get '/apishows', to: 'shows#find_shows'
      get '/apishows/:id', to: 'shows#show_details'

      get '/seasons/:showId', to: 'seasons#all_seasons'
      get '/seasons/:showId/:seasonId', to: 'seasons#season_data'

      resources :users, only: [:create]
      post '/login', to: 'auth#create'

      get '/profile', to: 'users#profile'
      post '/newUser', to: 'users#create'

    end
  end
end

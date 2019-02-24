Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :shows

      get '/apishows', to: 'shows#find_shows'
      get '/apishows/:id', to: 'shows#show_details'

      get '/seasons/:showId', to: 'seasons#all_seasons'
      get '/seasons/:showId/:seasonId', to: 'seasons#season_data'

      resources :users, only: [:create]
      post '/login', to: 'auth#create'

      get '/profile', to: 'users#profile'
      post '/newUser', to: 'users#create'

      # post '/watchlist', to: 'shows#create'
    end
  end
end

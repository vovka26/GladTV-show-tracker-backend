class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :api_id, :show_id, :season_id
end

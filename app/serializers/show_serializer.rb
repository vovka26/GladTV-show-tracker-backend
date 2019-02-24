class ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :genre, :image_url, :api_id
  # belongs_to :user
  has_many :episodes
end

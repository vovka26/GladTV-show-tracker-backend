class Actor < ApplicationRecord
  has_many :show_actors
  has_many :shows, through: :show_actors
end

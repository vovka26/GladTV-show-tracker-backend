class Show < ApplicationRecord
    has_many :user_shows
    has_many :users, through: :user_shows
    has_many :episodes
    has_many :seasons, through: :episodes

    # validates :api_id, uniqueness: {case_sensitive: false}
    # validates :title, uniqueness: {case_sensitive: false}
end

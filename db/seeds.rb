# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: 'hey', password: 'hey', first_name: 'Vladimir', last_name: 'Deryuzhenko')

show = Show.create(title: 'The Walking Dead', rating: 5, genre: 'Comedy', api_id: 43242342, image_url: 'http://')

season = Season.create(season_number: 1, api_id: 423423423)

episode = Episode.create(title: 'Episode 1', show_id: 1, season_id: 1, api_id: 321432)

user.shows << show
user.episodes << episode
# episode.shows << show
# episode.seasons << season

class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.time :length
      t.string :image_url
      t.date :air_date
      t.integer :show_id
      t.integer :season_id

      t.timestamps
    end
  end
end

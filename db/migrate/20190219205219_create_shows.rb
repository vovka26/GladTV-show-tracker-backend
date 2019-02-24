class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :title
      t.integer :rating
      t.string :genre
      t.string :image_url
      t.integer :api_id

      t.timestamps
    end
  end
end

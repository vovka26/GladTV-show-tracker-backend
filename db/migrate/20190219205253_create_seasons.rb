class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.integer :season_number
      t.integer :api_id

      t.timestamps
    end
  end
end

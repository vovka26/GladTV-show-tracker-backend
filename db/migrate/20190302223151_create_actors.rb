class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :name
      t.string :gender
      t.string :image_url
      t.integer :api_id

      t.timestamps
    end
  end
end

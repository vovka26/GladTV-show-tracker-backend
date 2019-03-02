class CreateShowActors < ActiveRecord::Migration[5.2]
  def change
    create_table :show_actors do |t|
      t.integer :show_id
      t.integer :actor_id

      t.timestamps
    end
  end
end

class CreateStoryGods < ActiveRecord::Migration[7.1]
  def change
    create_table :story_gods do |t|
      t.references :story, null: false, foreign_key: true
      t.references :god, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
    add_index :story_gods, [:story_id, :god_id], unique: true
  end
end

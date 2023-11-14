class CreateGods < ActiveRecord::Migration[7.1]
  def change
    create_table :gods do |t|
      t.string :name
      t.text :description
      t.references :mythology, null: false, foreign_key: true
      t.references :pantheon, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateMythologies < ActiveRecord::Migration[7.1]
  def change
    create_table :mythologies do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

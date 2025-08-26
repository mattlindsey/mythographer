class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.string :name, null: false
      t.string :instructions
      t.string :tool_choice
      t.json :tools, default: []
      t.timestamps
    end
  end
end

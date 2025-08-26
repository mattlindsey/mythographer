class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :assistant, foreign_key: true
      t.string :role, null: false
      t.text :content
      t.json :tool_calls, default: []
      t.string :tool_call_id
      t.timestamps
    end
  end
end

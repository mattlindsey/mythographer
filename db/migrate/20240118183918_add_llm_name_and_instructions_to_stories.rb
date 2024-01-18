class AddLlmNameAndInstructionsToStories < ActiveRecord::Migration[7.1]
  def change
    change_table :stories, bulk: true do |t|
      t.string :llm_name
      t.string :instructions
    end
  end
end

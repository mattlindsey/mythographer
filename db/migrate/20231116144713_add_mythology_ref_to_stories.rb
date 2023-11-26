class AddMythologyRefToStories < ActiveRecord::Migration[7.1]
  def change
    add_reference :stories, :mythology, null: false, foreign_key: true, default: 1
  end
end

class AddCreativityToStories < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :creativity, :string
  end
end

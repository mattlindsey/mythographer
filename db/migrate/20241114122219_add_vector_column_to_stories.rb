class AddVectorColumnToStories < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :embedding, :vector,
      limit: LangchainrbRails
        .config
        .vectorsearch
        .llm
        .default_dimensions
  end
end

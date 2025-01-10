class AddEmbeddingToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :embedding, :vector
  end
end

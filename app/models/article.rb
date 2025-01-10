class Article < ApplicationRecord
  acts_as_taggable_on :tags
  has_neighbors :embedding

  def generate_embedding!
    client = OpenAI::Client.new(
      uri_base: "http://localhost:11434"
    )

    response = client.embeddings(
      parameters: {
        model: "llama3",
        input: <<~INPUT
          #{title}
          #{tags.map(&:name)}
          #{body}
        INPUT
      }
    )

    update(embedding: response.dig("data", 0, "embedding"))
  end

  def related
    nearest_neighbors(:embedding, distance: "cosine").first(3)
  end
end

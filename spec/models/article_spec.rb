require 'rails_helper'

RSpec.describe Article do
  describe '#generate_embedding!' do
    it 'generates the embedding for an aritcle' do
      article = create(:article, tag_list: [ 'test' ])
      client = double(embeddings: { 'data' => [ 'embedding' => [ 3, 5, 9 ] ] })
      allow(OpenAI::Client).to receive(:new).and_return(client)

      article.generate_embedding!

      expect(client).to have_received(:embeddings).with(
        parameters: {
          model: "llama3",
          input: <<~INPUT
            #{article.title}
            #{article.tags.map(&:name)}
            #{article.body}
          INPUT
        }
      )
      expect(article.embedding).to eq [ 3, 5, 9 ]
    end
  end

  describe '#related' do
    it 'returns related articles' do
      article = create(:article, embedding: [ 1, 2, 3 ])
      article2 = create(:article, embedding: [ 1, 2, 3 ])
      article3 = create(:article, embedding: nil)

      expect(article2.related).to match_array([ article ])
    end
  end
end

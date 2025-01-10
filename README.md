# Rails AI

A simple proof of concept demonstrating how to use Rails with Ollama LLM (locally) to generate related articles.

# How it works

1. **Generate Vector Embeddings:**
  An article's title, tags, and body are used to create a vector embedding.

2. **Find Related Articles:**
  The vector embedding is compared to other article embeddings, and the closest vectors determine related articles.

# Requirements

- [pgvector](https://github.com/pgvector/pgvector#installation): For storing and querying vector embeddings in PostgreSQL
- [Ollama](https://ollama.com/): A locally hosted large language model (LLM)

# Setup

## Install and run Ollama Server

```
brew install ollama
ollama serve
ollama pull llama3:latest
```

## Seed data
Run the following command to populate your database with example data:
```
rails db:seed
```

## Generate Embeddings
Generate vector embeddings for all articles:
```
Article.all.each {|article| article.generate_embedding! }
```

# Notes
- Ensure pgvector is installed and configured in your PostgreSQL instance before running the application.
- For more information on how Ollama works or to troubleshoot installation issues, refer to the [Ollama documentation](https://ollama.com/).

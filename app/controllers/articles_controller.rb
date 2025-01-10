class ArticlesController < ApplicationController
  before_action :load_aricle, only: [ :update, :edit, :show, :destroy ]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def show
  end

  private

  def load_aricle
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :tag_list)
  end
end

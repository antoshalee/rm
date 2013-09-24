class ArticlesController < ApplicationController
  def index
    @articles = Article.order('published_at desc').decorate
  end

  def show
    @article = Article.find(params[:id]).decorate
  end
end

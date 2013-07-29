class StartController < ApplicationController
  def index
    @last_articles = Article.order('created_at desc').limit(3)
    @banners = Banner.order('position')
  end
end

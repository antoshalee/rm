class StartController < ApplicationController
  def index
    @last_articles = Article.order('created_at desc').limit(3)
    @banners = Banner.order('position')
    @offers = Offer.where(discount: false).limit(3)
    @last_album = Album.order('id').last
    @last_magazine = Magazine.order('position desc').first
  end
end

class AlbumsController < ApplicationController
  def index
    @albums = Album.order('created_at desc').limit(3)
  end

  def show
  end
end

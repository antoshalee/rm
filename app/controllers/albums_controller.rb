class AlbumsController < ApplicationController
  def index
    base = (params[:tag].present? ? Album.tagged_with(params[:tag]) : Album)
    @albums = base.order('published_at desc').page(params[:page]).per(5)

    render text: "", status: 404 and return if @albums.blank?

    if request.xhr?
      render partial: 'albums/list', locals: {with_first_separator: true}
    end
  end

  def show
    @album = Album.find params[:id]
  end
end

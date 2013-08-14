class AlbumsController < ApplicationController
  def index
    base = (params[:tag].present? ? Album.tagged_with(params[:tag]) : Album)
    @albums = base.order('created_at desc').page(params[:page]).per(1)

    if request.xhr?
      render partial: 'albums/list', locals: {with_first_separator: true}
    end
  end

  def show
  end
end

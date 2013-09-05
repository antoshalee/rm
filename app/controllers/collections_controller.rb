class CollectionsController < ApplicationController
  def index
    @collections = Collection.order('position asc')
    @collections = @collections.tagged_with(params[:tag]) if params[:tag].present?
    @body_id = "goods-grids"
  end

  def show
  end
end

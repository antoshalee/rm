class CatalogItemsController < ApplicationController
  def index
    @items = Catalog::Item.order("id asc").page(params[:page]).per(10)
    @categories = Catalog::Category.order("position asc")
    @inserts = Catalog::Insert.order("position asc")
    @body_id = "goods-grids"
  end
end

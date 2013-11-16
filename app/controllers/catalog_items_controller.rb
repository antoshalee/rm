class CatalogItemsController < ApplicationController
  helper_method :selected_category, :selected_insert, :selected_metal

  has_scope :by_insert, as: :insert
  has_scope :by_category, as: :category
  has_scope :by_metal, as: :metal
  has_scope :by_article, as: :article

  def index
    @items = apply_scopes(Catalog::Item).order("article asc").page(params[:page]).per(25)
    @categories = Catalog::Category.order("position asc")
    @inserts = Catalog::Insert.order("position asc")
    @metals = Catalog::Metal.order("position asc")
    @body_id = "goods-grids"
  end

  private

  def selected_category
    @selected_category ||= params[:category] && Catalog::Category.find(params[:category])
  end

  def selected_insert
    @selected_insert ||= params[:insert] && Catalog::Insert.find(params[:insert])
  end

  def selected_metal
    @selected_metal ||= params[:metal] && Catalog::Metal.find(params[:metal])
  end
end

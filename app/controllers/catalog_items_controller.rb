class CatalogItemsController < ApplicationController
  helper_method :selected_category, :selected_insert, :selected_metal

  has_scope :by_insert, as: :insert
  has_scope :by_category, as: :category
  has_scope :by_metal, as: :metal

  def index
    @items = apply_scopes(Catalog::Item).order("id asc").page(params[:page]).per(10)
    @categories = Catalog::Category.order("position asc")
    @inserts = Catalog::Insert.order("position asc")
    @body_id = "goods-grids"
  end

  private

  def selected_category
    @selected_category ||= Catalog::Category.find(params[:category]) if params[:category].present?
  end

  def selected_insert
    @selected_insert ||= Catalog::Insert.find(params[:insert]) if params[:insert].present?
  end

  def selected_metal
    @selected_metal ||= params[:metal] if params[:metal].present? && Catalog::Item::METALS.include?(params[:metal])
  end
end

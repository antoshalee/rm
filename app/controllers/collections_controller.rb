class CollectionsController < ApplicationController
  def index
    @collections = Collection.order('position asc')
    @collections = @collections.tagged_with(params[:tag]) if params[:tag].present?
  end

  def show
  end
end

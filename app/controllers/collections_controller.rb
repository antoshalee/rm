class CollectionsController < ApplicationController
  def index
    @collections = (params[:tag].present? ? Collection.tagged_with(params[:tag]) : Collection.all)
  end

  def show
  end
end

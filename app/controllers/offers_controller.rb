class OffersController < ApplicationController
  def index
    base = (params[:tag].present? ? Offer.tagged_with(params[:tag]) : Offer)
    @main_offer = base.main.first
    @offers = base.common
  end

  def show
    @offer = Offer.find params[:id]
  end
end

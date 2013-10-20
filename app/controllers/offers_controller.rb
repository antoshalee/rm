class OffersController < ApplicationController
  def index
    base = (params[:tag].present? ? Offer.tagged_with(params[:tag]) : Offer)
    base = base.order("position asc")
    @main_offer = base.main.first
    @offers = base.common.not_discount
    @discounts = base.discount
  end

  def show
    @offer = Offer.find params[:id]
  end
end

class OffersController < ApplicationController
  def index
    @main_offer = Offer.main.first
    @offers = Offer.common
  end

  def show
    @offer = Offer.find params[:id]
  end
end

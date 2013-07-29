class OffersController < ApplicationController
  def index
    @main_offer = Offer.main.first
    @offers = Offer.common
  end

  def show
  end
end

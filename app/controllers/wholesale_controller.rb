class WholesaleController < ApplicationController
  def index
    @suppliers = Supplier.order('position asc')
    @letters = Letter.order('position asc')
    @managers = WholesaleManager.order('position asc')
  end
end

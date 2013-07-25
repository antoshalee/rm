class WholesaleController < ApplicationController
  def index
    @suppliers = Supplier.order('position asc')
  end
end

class StoresController < ApplicationController
  def addresses
  	@top_store = Store.order("position asc").first
  	@stores = Store.order("position asc").all[1..-1]
  end
end

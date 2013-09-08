class MagazinesController < ApplicationController
  def index
    @magazines = Magazine.order('position asc')
    @main_magazine = @magazines.shift
  end

  def show
    @magazine = Magazine.find params[:id]
  end
end

class MagazinesController < ApplicationController
  def index
    @magazines = Magazine.order('position')
  end
end

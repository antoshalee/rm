class MagazinesController < ApplicationController
  def index
    @magazines = Magazine.order('position desc')
  end
end

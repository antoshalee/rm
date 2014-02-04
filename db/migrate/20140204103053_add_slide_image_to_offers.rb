class AddSlideImageToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :slide_image, :string
  end
end

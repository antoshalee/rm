# encoding: utf-8

class StoreImageUploader < BaseImageUploader
  version :main do
    process resize_to_limit: [350, 220]
  end
end

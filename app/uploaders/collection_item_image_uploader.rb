# encoding: utf-8

class CollectionItemImageUploader < BaseImageUploader

  version :thumb do
    process resize_to_limit: [450, 450]
  end
end

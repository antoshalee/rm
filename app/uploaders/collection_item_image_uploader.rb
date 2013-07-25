# encoding: utf-8

class CollectionItemImageUploader < BaseImageUploader

  version :thumb do
    process :resize_to_fill => [225, 170]
  end
end

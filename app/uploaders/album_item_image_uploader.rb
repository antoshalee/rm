# encoding: utf-8

class AlbumItemImageUploader < BaseImageUploader
  version :thumb do
    process :resize_to_fill => [180, 120]
  end
end

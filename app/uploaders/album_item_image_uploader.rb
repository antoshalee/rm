# encoding: utf-8

class AlbumItemImageUploader < BaseImageUploader
  version :thumb do
    process :resize_to_limit => [0, 132]
  end

  version :fullscreen do
    process :resize_to_limit => [1024, 1024]
  end
end

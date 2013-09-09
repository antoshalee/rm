# encoding: utf-8
class LetterImageUploader < BaseImageUploader

  version :main do
    process resize_to_fill: [130, 180]
  end
end

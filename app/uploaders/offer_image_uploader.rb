# encoding: utf-8
class OfferImageUploader < BaseImageUploader

  version :aside do
    process resize_to_fill: [190,160]
  end

  version :main do
    process resize_to_limit: [512, 512]
  end
end

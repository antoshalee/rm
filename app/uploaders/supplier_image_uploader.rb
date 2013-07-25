# encoding: utf-8
class SupplierImageUploader < BaseImageUploader
  version :main do
    process :resize_to_fill => [168, 113]
  end
end
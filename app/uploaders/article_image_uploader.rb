# encoding: utf-8

class ArticleImageUploader < BaseImageUploader
  version :fullscreen do
    process :resize_to_limit => [1024, 1024]
  end
end

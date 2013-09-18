# -*- encoding : utf-8 -*-
# CarrierWave.configure do |config|
#   if Rails.env.production?
#     config.storage = :fog
#     config.fog_credentials = {
#       :provider               => 'AWS',
#       :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],
#       :aws_secret_access_key  =>  ENV['S3_SECRET_ACCESS_KEY'],
#       :region                 => 'us-east-1'
#     }

#     config.fog_directory  = ENV['S3_BUCKET'] # required
#     config.asset_host     = nil # optional, defaults to nil
#     config.fog_public     = true # optional, defaults to true
#     config.fog_attributes = {}  # optional, defaults to {}
#     config.cache_dir = "#{Rails.root}/tmp/uploads"

#   else
#     config.storage = :file
#     config.permissions = 0666
#     config.cache_dir = "#{Rails.root}/public/uploads/tmp"
#   end

# end

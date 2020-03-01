require 'carrierwave/storage/abstract'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'rails-photo-dietter'
  config.cache_storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWSS3ACCESSKEY'],
    aws_secret_access_key: ENV['AWSS3SECRETKEY'],
    region: 'us-east-1'
  }

end
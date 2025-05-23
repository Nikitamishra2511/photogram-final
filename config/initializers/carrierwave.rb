# config/initializers/carrierwave.rb
require "carrierwave"
require "carrierwave/orm/activerecord"

CarrierWave.configure do |config|
  # store uploads under public/
  config.root      = Rails.root.join("public")
  # cache uploads temporarily here
  config.cache_dir = "tmp/uploads"
end

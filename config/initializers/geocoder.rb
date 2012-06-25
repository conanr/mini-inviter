Geocoder.configure do |config|
  config.lookup  = :bing
  config.api_key = ENV['BING_MAPS_API_KEY']
  config.timeout = 5
end
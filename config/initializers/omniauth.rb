OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET']
end
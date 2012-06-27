OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,   ENV['FACEBOOK_KEY'],    ENV['FACEBOOK_SECRET']
  provider :foursquare, ENV['FOURSQUARE_KEY'],  ENV['FOURSQUARE_SECRET']
end
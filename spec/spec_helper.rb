# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/spec/"
end
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  FactoryGirl.find_definitions
  
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new({
      :provider => 'foursquare',
      :uid      => "1234",
      :info     => { :first_name => "Paula", :last_name => "Brewman", :email => "dcbrewman@example.org" },
      :credentials => { :token => "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL" }
  })

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid      => "098765",
      :info     => { :first_name => "Niels", :last_name => "Bohr", :email => "n.bohr@example.org" },
      :credentials => { :token => "PMUD44LT0D2FEDY0IBX0NY2QNE1SNL3NH22I530TIAIY5CXW" }
  })

  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid      => "1234",
      :info     => { :first_name => "Tamara", :last_name => "Cane", :email => "t.cane@example.org" },
      :credentials => { :token => "D2FEDY0IBX0NY2QNE1SNL3NH22I530TIAIY5CXWPMUD44LT0" }
  })
  
  config.before(:each) do
   Restaurant.any_instance.stub(:geocode).and_return([1,1])
   Restaurant.stub(:near).and_return([])
  end
end

FactoryGirl.define do
  factory :user do
    email       { Faker::Internet.email }
    first_name  'Paula'
    last_name   'Brewman'
  end
end
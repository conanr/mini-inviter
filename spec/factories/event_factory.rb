FactoryGirl.define do
  factory :event do
    user
    name  'Pretend Time'
    schedule
    address
  end
end
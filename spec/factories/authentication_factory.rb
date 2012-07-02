FactoryGirl.define do
  factory :authentication do
    provider      'facebook'
    uid           "098765"
    token         "PMUD44LT0D2FEDY0IBX0NY2QNE1SNL3NH22I530TIAIY5CXW"
    
    factory :facebook_auth do
    end
  end
end
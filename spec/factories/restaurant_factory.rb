FactoryGirl.define do
  factory :restaurant do
    name    "Sushi Go Round"
    address "705 7th Street NW Washington, DC 20001"
    ls_id   "2166"
  
    factory :sushi_go_round do
    end
  
    factory :cafe_mozart do
      name    "Cafe Mozart"
      address "1331 H Street NW Washington, DC 20005"
      ls_id   "139"
    end
  
    factory :mayur_kabob_house do
      name    "Mayur Kabob House"
      address "1108 K Street NW Washington, DC 20005"
      ls_id   "63"
    end
  end
end
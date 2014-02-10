FactoryGirl.define do
  factory :campaign do
    name { Faker::Company.bs }
    association :organization
  end
end

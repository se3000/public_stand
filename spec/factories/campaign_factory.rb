FactoryGirl.define do
  factory :campaign do
    name { Faker::Company.bs }
    association :organization
    vanity_string { Faker::Company.name.gsub(' ', '_') }
  end
end

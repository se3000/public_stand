FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    vanity_string { Faker::Company.name.gsub(' ', '_') }
  end
end

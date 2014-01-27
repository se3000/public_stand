FactoryGirl.define do
  factory :membership do
    association :member, class_name: 'User'
    association :organization
  end
end

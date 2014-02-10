FactoryGirl.define do
  factory :phone_call do
    association :campaign
    association :target
  end
end

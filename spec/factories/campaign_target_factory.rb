FactoryGirl.define do
  factory :campaign_target do
    association :campaign
    association :target
  end
end

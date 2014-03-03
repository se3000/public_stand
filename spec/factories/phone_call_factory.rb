FactoryGirl.define do
  factory :phone_call do
    association :campaign_target
    twilio_token { Faker::Code.isbn }
  end
end

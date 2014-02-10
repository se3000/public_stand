FactoryGirl.define do
  factory :phone_call do
    association :campaign
    association :target
    twilio_token { Faker::Code.isbn }
  end
end

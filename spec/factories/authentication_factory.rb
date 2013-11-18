FactoryGirl.define do
  factory :authentication do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { password }
  end
end

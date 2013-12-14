class PhoneCall < ActiveRecord::Base
  belongs_to :campaign

  validates :campaign, :twilio_token, presence: true
end

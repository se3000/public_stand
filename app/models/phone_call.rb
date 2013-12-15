class PhoneCall < ActiveRecord::Base
  belongs_to :campaign

  validates :campaign, presence: true
  validates :twilio_token, presence: true, uniqueness: true

  before_validation :generate_twilio_token, on: :create


  private

  def generate_twilio_token
    self.twilio_token = TwilioClient.outgoing_token
  end
end

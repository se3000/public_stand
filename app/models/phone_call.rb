class PhoneCall < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :target

  validates :campaign, presence: true
  validates :target, presence: true
  validates :twilio_token, presence: true, uniqueness: true

  before_validation :generate_twilio_token, on: :create

  delegate :phone_number, to: :target, prefix: true

  def start
    TwilioClient.begin_call(self)
  end


  private

  def generate_twilio_token
    self.twilio_token ||= TwilioClient.outgoing_token
  end
end

class PhoneCall < ActiveRecord::Base
  belongs_to :campaign_target

  validates :campaign_target, presence: true
  validates :twilio_token, presence: true, uniqueness: true

  before_validation :generate_twilio_token, on: :create

  delegate :phone_number, to: :target, prefix: true

  scope :completed, ->{ where(status: 'completed') }

  def start
    TwilioClient.begin_call(self)
  end


  private

  delegate :campaign, :target, to: :campaign_target

  def generate_twilio_token
    self.twilio_token ||= TwilioClient.outgoing_token
  end
end

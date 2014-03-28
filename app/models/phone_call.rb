class PhoneCall < ActiveRecord::Base
  belongs_to :campaign_target
  has_one :feedback, class_name: "PhoneCallFeedback"

  validates :campaign_target, presence: true
  validates :twilio_token, presence: true, uniqueness: true

  before_validation :generate_twilio_token, on: :create

  scope :completed, ->{ where(status: 'completed') }

  def start
    TwilioClient.begin_call(self)
  end

  def target_phone_number
    target.phone_number
  end

  def outgoing_number
    campaign_target.outgoing_number
  end

  def supporter_phone_number=(phone_number)
    self.from_number = phone_number.to_s.gsub(/[^0-9]/,'')
  end


  private

  delegate :campaign, :target, to: :campaign_target

  def generate_twilio_token
    self.twilio_token ||= TwilioClient.outgoing_token
  end
end

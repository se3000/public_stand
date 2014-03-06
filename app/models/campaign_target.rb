class CampaignTarget < ActiveRecord::Base
  belongs_to :campaign, inverse_of: :campaign_targets
  belongs_to :target, inverse_of: :campaign_targets
  has_many :phone_calls, inverse_of: :campaign_target

  validates :campaign, :target, presence: true
  validates :twitter_share_text, length: {maximum: 118}

  accepts_nested_attributes_for :target

  def average_call_time
    return unless completed_phone_calls.any?
    average = completed_phone_calls.average(:call_duration)
    minutes = average.to_i / 60
    seconds = (average % 60).to_i
    "#{minutes}:#{0 if seconds < 10}#{seconds}"
  end

  def suggested_tweet
    twitter_share_text.present? ? twitter_share_text : campaign.name
  end

  def outgoing_number
    twilio_number || TwilioClient::APP_PHONE_NUMBER
  end

  private

  def completed_phone_calls
    @completed_phone_call ||= phone_calls.completed
  end
end

class CampaignTarget < ActiveRecord::Base
  belongs_to :campaign, inverse_of: :campaign_targets
  belongs_to :target

  validates :campaign, :target, presence: true

  accepts_nested_attributes_for :target

  def average_call_time
    return unless phone_calls.any?
    average = phone_calls.completed.average(:call_duration)
    minutes = average.to_i / 60
    seconds = (average % 60).to_i
    "#{minutes}:#{seconds}"
  end

  private

  def phone_calls
    PhoneCall.where(campaign_id: campaign_id, target_id: target_id)
  end
end

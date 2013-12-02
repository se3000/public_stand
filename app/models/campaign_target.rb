class CampaignTarget < ActiveRecord::Base
  belongs_to :campaign, inverse_of: :campaign_targets
  belongs_to :target

  validates :campaign, :target, presence: true

  accepts_nested_attributes_for :target
end

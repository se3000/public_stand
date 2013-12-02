class CampaignTarget < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :target

  validates :campaign, :target, presence: true
end

class Campaign < ActiveRecord::Base
  belongs_to :organization
  has_many :campaign_targets, inverse_of: :campaign
  has_many :phone_calls
  has_many :targets, through: :campaign_targets

  validates :organization, :name, presence: true

  accepts_nested_attributes_for :campaign_targets
end

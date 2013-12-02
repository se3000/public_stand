class Campaign < ActiveRecord::Base
  belongs_to :organization
  has_many :campaign_targets
  has_many :targets, through: :campaign_targets

  validates :organization, :name, presence: true

  accepts_nested_attributes_for :targets
end

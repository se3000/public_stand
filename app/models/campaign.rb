class Campaign < ActiveRecord::Base
  belongs_to :organization
  has_many :campaign_targets, inverse_of: :campaign
  has_many :phone_calls
  has_many :targets, through: :campaign_targets
  has_one :picture

  validates :organization, :name, presence: true
  validates :vanity_string, presence: true, uniqueness: {scope: [:organization_id]}

  after_create :create_picture

  accepts_nested_attributes_for :campaign_targets
end

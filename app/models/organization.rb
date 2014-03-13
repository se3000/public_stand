class Organization < ActiveRecord::Base
  has_many :campaigns
  has_many :memberships, inverse_of: :organization
  has_many :members, through: :memberships

  validates :name, presence: true
  validates :vanity_string, presence: true, uniqueness: true

  def self.lookup(host_url, vanity_string, organization_id)
    organization = find_by_host_url(host_url) if host_url.present?
    organization || find_by_vanity_string(vanity_string) || find(organization_id)
  end

  def campaign_lookup(vanity_string, campaign_id)
    campaigns.find_by_vanity_string(vanity_string) || campaigns.find_by_id(campaign_id)
  end
end

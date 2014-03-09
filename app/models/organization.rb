class Organization < ActiveRecord::Base
  has_many :campaigns
  has_many :memberships, inverse_of: :organization
  has_many :members, through: :memberships

  validates :name, :vanity_string, presence: true
end

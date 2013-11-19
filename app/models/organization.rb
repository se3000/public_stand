class Organization < ActiveRecord::Base
  has_many :campaigns
  has_many :memberships
  has_many :members, through: :memberships

  validates :name, presence: true
end

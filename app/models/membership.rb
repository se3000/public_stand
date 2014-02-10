class Membership < ActiveRecord::Base
  belongs_to :member, class_name: 'User'
  belongs_to :organization, inverse_of: :memberships

  validates :member, :organization, presence: true
end

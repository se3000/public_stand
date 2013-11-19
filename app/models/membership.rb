class Membership < ActiveRecord::Base
  belongs_to :member, class_name: 'User'
  belongs_to :organization

  validates :member, :organization, presence: true
end

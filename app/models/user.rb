class User < ActiveRecord::Base
  has_one :authentication, inverse_of: :user
  has_many :memberships, foreign_key: :member_id
  has_many :organizations, through: :memberships
end

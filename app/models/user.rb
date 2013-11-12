class User < ActiveRecord::Base
  has_one :authentication, inverse_of: :user

  validates :first_name, :last_name, presence: true
end

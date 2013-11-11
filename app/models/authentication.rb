class Authentication < ActiveRecord::Base
  has_secure_password

  belongs_to :user, inverse_of: :authentication

  validates :user, presence: true, on: :update

  after_create :create_user
end

class Authentication < ActiveRecord::Base
  has_secure_password

  belongs_to :user, inverse_of: :authentication

  validates :user, presence: true, on: :update

  def self.authenticate(email, password)
    auth = find_by_email(email)
    auth if auth && auth.authenticate(password)
  end
end

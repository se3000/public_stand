class User < ActiveRecord::Base
  has_one :authentication, inverse_of: :user
end

class PhoneCallFeedback < ActiveRecord::Base
  belongs_to :phone_call
  validates :phone_call, presence: true
end

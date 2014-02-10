class Target < ActiveRecord::Base

  has_many :phone_calls

  validates :phone_number, format: { with: /\d{10}/ }

  def phone_number=(number)
    super number.to_s.gsub(/\D/, '')
  end
end

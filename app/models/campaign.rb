class Campaign < ActiveRecord::Base
  belongs_to :organization

  validates :organization, :name, presence: true
end

class Picture < ActiveRecord::Base
  mount_uploader :uploader, PictureUploader

  belongs_to :campaign
end

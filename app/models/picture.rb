class Picture < ActiveRecord::Base
  mount_uploader :uploader, PictureUploader

  belongs_to :campaign

  def url
    return unless s3_key.present?
    "http://s3-us-west-2.amazonaws.com/#{ENV['AWS_BUCKET']}/#{s3_key}"
  end

  def uploader_changed?
    false
  end
end

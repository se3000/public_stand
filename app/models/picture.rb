class Picture < ActiveRecord::Base
  mount_uploader :uploader, PictureUploader

  belongs_to :campaign

  def url
    return unless s3_key.present?
    "http://#{ENV['AWS_S3_SUBDOMAIN']}.amazonaws.com/#{ENV['AWS_BUCKET']}/#{s3_key}"
  end

  def uploader_changed?
    false
  end
end

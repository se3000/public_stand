class PicturesController < ApplicationController
  load_and_authorize_resource

  def edit
    @campaign = @picture.campaign
    @organization = @campaign.organization
    build_picture_uploader
  end

  def s3_update
    picture = Picture.find(params[:picture_id])
    campaign = picture.campaign
    organization = campaign.organization

    picture.s3_key = params[:key]
    picture.save!

    redirect_to [organization, campaign]
  end

  def build_picture_uploader
    @picture_uploader = @picture.uploader
    @picture_uploader.success_action_redirect = ENV['ROOT_URL'] + "/pictures/#{@picture.id}/s3_update"
  end

end

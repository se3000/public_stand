class PicturesController < ApplicationController
  def s3_update
    picture = Picture.find(params[:picture_id])
    campaign = picture.campaign
    organization = campaign.organization

    picture.s3_key = params[:key]
    picture.save!

    redirect_to [organization, campaign]
  end
end

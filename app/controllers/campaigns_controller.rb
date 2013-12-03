class CampaignsController < ApplicationController

  def new
    @organization = Organization.find(params[:organization_id])
    @campaign = Campaign.new
    build_campaign_target
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.build(Params.clean params)

    if @campaign.save
      flash.notice = 'Successfully created a new campaign'
      redirect_to [@organization, @campaign]
    else
      build_campaign_target
      flash.now.alert = @campaign.errors.full_messages
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.find(params[:id])
    @twilio_token = TwilioClient.outgoing_token
  end


  private

  def build_campaign_target
    @campaign_target = @campaign.campaign_targets.build
    @target = @campaign_target.build_target
  end

  class Params
    def self.clean(params)
      params.require(:campaign).permit(
        :name,
        :description,
        campaign_targets_attributes: [
          :script,
          target_attributes: [:name, :phone_number]
        ]
      )
    end
  end
end

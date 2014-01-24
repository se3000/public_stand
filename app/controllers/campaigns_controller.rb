class CampaignsController < ApplicationController
  skip_before_filter :ensure_authenticated
  load_and_authorize_resource through: :organization

  def new
    @organization = Organization.find(params[:organization_id])
    @campaign = Campaign.new
    build_campaign_target
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.find(params[:id])
    @campaign_target = @campaign.campaign_targets.first
    @target = @campaign_target.target
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

  def update
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.find(params[:id])

    if @campaign.update_attributes(Params.clean(params))
      flash.notice = 'Campaign successfully updated'
      redirect_to [@organization, @campaign]
    else
      @campaign_target = @campaign.campaign_targets.first
      @target = @campaign_target.target
      flash.now.alert = @campaign.errors.full_messages
      render :edit
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.find(params[:id])
    @twilio_token = TwilioClient.outgoing_token
  end


  private

  def organization
    Organization.find(params[:organization_id])
  end

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

  def campaign_params
    Params.clean(params)
  end
end

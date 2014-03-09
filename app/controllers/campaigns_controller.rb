class CampaignsController < ApplicationController
  load_and_authorize_resource through: :organization

  def new
    build_campaign_target
  end

  def edit
    @campaign_target = @campaign.campaign_targets.first
    @target = @campaign_target.target
  end

  def create
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
    @picture = @campaign.picture
    @twilio_token = TwilioClient.outgoing_token
    @auto_trigger = !!params[:auto]
    @phone_call = @campaign.phone_calls.build
  end


  private

  def organization
    return @organization if @organization
    @organization = Organization.find_by_vanity_string(request.subdomain)
    @organization ||= Organization.find(params[:organization_id])
    if params[:campaign_vanity] || params[:id]
      @campaign = @organization.campaigns.find_by_vanity_string(params[:campaign_vanity])
      @campaign ||= @organization.campaigns.find_by_id(params[:id])
    else
      @campaign = @organization.campaigns.build
    end
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
        :vanity_string,
        campaign_targets_attributes: [
          :id,
          :campaign_id,
          :target_id,
          :script,
          :twitter_share_text,
          target_attributes: [:name, :phone_number]
        ]
      )
    end
  end

  def campaign_params
    Params.clean(params)
  end
end

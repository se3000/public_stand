class CampaignsController < ApplicationController
  load_and_authorize_resource through: :organization
  before_filter :lookup_organization_and_campaign

  def new
    build_campaign_target
  end

  def edit
    @campaign_target = campaign.campaign_targets.first
    @target = @campaign_target.target
  end

  def create
    if campaign.save
      flash.notice = 'Successfully created a new campaign'
      redirect_to campaign_vanity(campaign)
    else
      build_campaign_target
      flash.now.alert = campaign.errors.full_messages
      render :new
    end
  end

  def update
    if campaign.update_attributes(Params.clean(params))
      flash.notice = 'Campaign successfully updated'
      redirect_to campaign_vanity(campaign)
    else
      @campaign_target = campaign.campaign_targets.first
      @target = @campaign_target.target
      flash.now.alert = campaign.errors.full_messages
      render :edit
    end
  end

  def show
    @picture = campaign.picture
    @twilio_token = TwilioClient.outgoing_token
    @auto_trigger = !!params[:auto]
    @phone_call = @campaign.campaign_targets.first.phone_calls.build
  end

  private

  def build_campaign_target
    @campaign_target = campaign.campaign_targets.build
    @target = @campaign_target.build_target
  end

  def organization
    @organization ||= Organization.lookup(request.host, request.subdomain, params[:organization_id])
  end

  def campaign
    @campaign ||= organization.campaign_lookup(params[:campaign_vanity], params[:id]) ||
      organization.campaigns.build
    @campaign
  end

  def lookup_organization_and_campaign
    organization and campaign
  end

  class Params
    def self.clean(params)
      attributes = params.require(:campaign).permit(
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
      attributes.values.map{|value| value.strip! if value.respond_to?(:strip!) }
      attributes
    end
  end

  def campaign_params
    Params.clean(params)
  end
end

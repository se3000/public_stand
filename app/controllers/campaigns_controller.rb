class CampaignsController < ApplicationController

  def new
    @organization = Organization.find(params[:organization_id])
    @campaign = Campaign.new
    @target = @campaign.targets.build
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.build(Params.clean params)

    if @campaign.save
      flash.notice = 'Successfully created a new campaign'
      redirect_to [@organization, @campaign]
    else
      flash.now.alert = @campaign.errors.full_messages
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @campaign = @organization.campaigns.find(params[:id])
  end

  class Params
    def self.clean(params)
      params.require(:campaign).permit(:name, :description, targets_attributes: [:name, :phone_number])
    end
  end
end

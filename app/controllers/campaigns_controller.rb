class CampaignsController < ApplicationController
  def new
    @campaign = Campaign.new
  end
end

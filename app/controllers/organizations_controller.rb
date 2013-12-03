class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(Params.clean(params))

    if @organization.save
      current_user.memberships.create(organization: @organization)
      flash.notice = "Successfully created new organization!"
      redirect_to @organization
    else
      flash.now.alert = @organization.errors.full_messages
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  class Params
    def self.clean(params)
      params.require(:organization).permit(:name, :description)
    end
  end
end

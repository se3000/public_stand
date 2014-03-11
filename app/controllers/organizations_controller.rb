class OrganizationsController < ApplicationController
  load_and_authorize_resource

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
      flash.now.alert = organization.errors.full_messages
      render :new
    end
  end

  def update
    organization = Organization.find(params[:id])

    if organization.update_attributes(Params.clean(params))
      flash.notice = "Successfully updated organization"
      redirect_to organization
    else
      flash.now.alert = organization.errors.full_messages
      render :edit
    end
  end

  def show
    organization
  end

  class Params
    def self.clean(params)
      params.require(:organization).permit(:name, :description, :vanity_string)
    end
  end


  private

  def organization
    return @organization if @organization.present?
    @organization = Organization.find_by_vanity_string(request.subdomain)
    @organization ||= Organization.find_by_host_url(request.host)
    @organization ||= Organization.find(params[:organization_id])
  end

  def organization_params
    Params.clean(params)
  end
end

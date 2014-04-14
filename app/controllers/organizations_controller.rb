class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_organization, except: [:new, :create]

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      current_user.memberships.create(organization: @organization)
      flash.notice = "Successfully created new organization!"
      redirect_to organization_vanity(organization)
    else
      flash.now.alert = organization.errors.full_messages
      render :new
    end
  end

  def update
    if organization.update_attributes(organization_params)
      flash.notice = "Successfully updated organization"
      redirect_to organization_vanity(organization)
    else
      flash.now.alert = organization.errors.full_messages
      render :edit
    end
  end

  private

  def organization
    @organization ||= Organization.lookup(request.host, request.subdomain, params[:organization_id])
  end

  def lookup_organization
    organization
  end

  def organization_params
    Params.clean(params)
  end

  class Params
    def self.clean(params)
      params.require(:organization).permit(:name, :description, :vanity_string)
    end
  end
end

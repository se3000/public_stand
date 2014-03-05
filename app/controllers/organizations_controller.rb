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
      flash.now.alert = @organization.errors.full_messages
      render :new
    end
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update_attributes(Params.clean(params))
      flash.notice = "Successfully updated organization"
      redirect_to @organization
    else
      flash.now.alert = @organization.errors.full_messages
      render :edit
    end
  end

  def show
    @organization = Organization.find(params[:id])
    if can?(:manage, @organization)
      render :show
    else
      redirect_to new_session_path
    end

  end

  class Params
    def self.clean(params)
      params.require(:organization).permit(:name, :description)
    end
  end


  private

  def organization_params
    Params.clean(params)
  end
end

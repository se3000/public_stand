class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
  end

  def create
    @organization = current_user.organizations.build(Params.clean(params))

    if @organization.save
      flash.notice = "Successfully created new organization!"
      redirect_to @organization
    else
      flash.now.alert = @organization.errors.full_messages
      render :new
    end
  end

  class Params
    def self.clean(params)
      params.require(:organization).permit(:name, :description)
    end
  end
end

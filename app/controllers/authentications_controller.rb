class AuthenticationsController < ApplicationController

  def new
    @authentication = Authentication.new
  end

end

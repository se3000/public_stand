require 'spec_helper'

describe UsersController do
  describe "#edit" do
    get :edit, user_id: user.id
  end
end

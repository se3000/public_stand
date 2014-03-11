require 'spec_helper'

describe OrganizationsController do
  let(:current_user) { users(:gillian) }
  let(:organization) { current_user.organizations.first }
  before { log_in current_user }

  describe "#new" do
    before { log_in users(:gillian) }

    it "renders a new organization" do
      get :new

      expect(response).to be_success
      expect(assigns(:organization)).to be_a Organization
    end
  end

  describe "#edit" do
    it "renders a new organization" do
      get :edit, id: organization.id

      expect(response).to be_success
      expect(assigns(:organization)).to eq(organization)
    end
  end

  describe "#create" do
    context "when the organization is valid" do
      let(:organization_params) { FactoryGirl.attributes_for(:organization) }

      it "creates a new instance of Organization" do
        expect {
          post :create, organization: organization_params
        }.to change { Organization.count }.by(+1)
        expect(current_user.organizations).to include Organization.last
      end

      it "redirects to the new organization page" do
        post :create, organization: organization_params

        expect(response).to redirect_to Organization.last
      end
    end

    context "when the organization is not valid" do
      let(:organization_params) { {name: nil} }

      it "does not create a new instance of Organization" do
        expect {
          post :create, organization: organization_params
        }.not_to change { Organization.count }
      end

      it "renders the new template" do
        post :create, organization: organization_params

        expect(response).to render_template :new
      end
    end
  end

  describe "#update" do
    context "when the organization is valid" do
      let(:organization_params) { {name: "New Name"} }

      it "creates a new instance of Organization" do
        patch :update, id: organization.id, organization: organization_params

        expect(organization.reload.name).to eq('New Name')
      end

      it "redirects to the new organization page" do
        patch :update, id: organization.id, organization: organization_params

        expect(response).to redirect_to organization
      end
    end

    context "when the organization is not valid" do
      let(:organization_params) { {name: nil} }

      it "renders the edit template" do
        patch :update, id: organization.id, organization: organization_params

        expect(response).to render_template :edit
      end
    end
  end

  describe "#show" do
    context "when using subdomains" do
      before do
        @request.host = "#{organization.vanity_string}.example.com"
      end

      it "creates a new instance of Authentication" do
        get :show

        expect(assigns :organization).to eq organization
      end
    end

    context "when hosting on another site" do
      before do
        host = 'foobarbaz.om'
        organization.update_attributes(host_url: host)
        @request.host = host
      end

      it "creates a new instance of Authentication" do
        get :show

        expect(assigns :organization).to eq organization
      end
    end

    context "when using reqular params" do
      it "creates a new instance of Authentication" do
        get :show, id: organization.id

        expect(assigns :organization).to eq organization
      end
    end
  end
end

describe "OrganizationsController::Params" do
  describe ".clean" do
    it "removes everything other than email, password, and password_confirmation" do
      params = ActionController::Parameters.new(organization: {
          name: 'Required',
          description: 'Not Required',
          email: 'email@example.com',
          vanity_string: 'ouch'
        },
        otro: "Woah, no."
      )

      cleaned = OrganizationsController::Params.clean(params)

      expect(cleaned).to eq({name: 'Required', description: 'Not Required', vanity_string: 'ouch'}.with_indifferent_access)
    end
  end
end

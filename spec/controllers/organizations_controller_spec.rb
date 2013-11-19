require 'spec_helper'

describe OrganizationsController do
  describe "#new" do
    before { log_in users(:zoe) }

    it "renders a new organization" do
      get :new

      expect(response).to be_success
      expect(assigns(:organization)).to be_a Organization
    end
  end

  describe "#create" do
    before { log_in users(:zoe) }

    context "when the organization is valid" do
      let(:organization_params) { {name: "Clear Water Initiative"} }

      it "creates a new instance of Organization" do
        expect {
          post :create, organization: organization_params
        }.to change { Organization.count }.by(+1)
      end

      it "redirects to the new organization page" do
        post :create, organization: organization_params

        expect(response).to redirect_to Organization.last
      end
    end

    context "when the organization is not valid" do
      let(:organization_params) { {name: nil} }

      it "creates a new instance of Organization" do
        expect {
          post :create, organization: organization_params
        }.not_to change { Organization.count }
      end

      it "creates a new instance of Organization" do
        post :create, organization: organization_params

        expect(response).to render_template :new
      end
    end
  end

  describe "#show" do
    before { log_in users(:zoe) }

    let(:organization) { Organization.first }

    it "creates a new instance of Authentication" do
      get :show, id: organization.id

      expect(assigns :organization).to eq organization
    end
  end
end

describe "OrganizationsController::Params" do
  describe ".clean" do
    it "removes everything other than email, password, and password_confirmation" do
      params = ActionController::Parameters.new(organization: {
          name: 'Required',
          description: 'Not Required',
          email: 'email@example.com'
        },
        otro: "Woah, no."
      )

      cleaned = OrganizationsController::Params.clean(params)

      expect(cleaned).to eq({name: 'Required', description: 'Not Required'}.with_indifferent_access)
    end
  end
end

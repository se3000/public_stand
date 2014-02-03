require 'spec_helper'

describe PicturesController do
  describe "#edit" do
    let(:user) { users(:gillian)  }
    let(:campaign) { user.organizations.first.campaigns.first }
    let(:picture) { FactoryGirl.create(:picture, campaign: campaign) }

    before { log_in user }

    it "sets up an uploader" do
      get :edit, id: picture.id

      expect(assigns :picture_uploader).to be_a PictureUploader

      expect(assigns :campaign).to eq(campaign)
      expect(assigns :organization).to eq(campaign.organization)
    end
  end

  describe "#s3_update" do
    # example params:
    # {
      # "bucket"=>"publicstand-development",
      # "key"=>"uploads/uploader/1/3b16afc2-382b-4c52-8fdf-c0e1f88724ef/Screen Shot 2013-12-30 at 4.20.18 PM.png",
      # "etag"=>"\"5a4ad7510d533f9ff17ce98f50137451\"",
      # "action"=>"s3_update",
      # "controller"=>"pictures",
      # "picture_id"=>"1"
    # }
    let(:user) { users(:gillian)  }
    let(:campaign) { user.organizations.first.campaigns.first }
    let(:picture) { FactoryGirl.create(:picture, campaign: campaign) }
    let(:params) do
      {
        bucket: "publicstand-development",
        key: "bogus_key.jpg",
        etag: "\"5a4ad7510d533f9ff17ce98f50137451\"",
        picture_id: picture.id
      }
    end

    before { log_in user }

    it "updates the pictures's remote url" do
      expect {
        get :s3_update, params
      }.to change{ picture.reload.s3_key }.from(nil).to('bogus_key.jpg')
    end

    it "redirects to the picture's campaign" do
      get :s3_update, params
      expect(response).to redirect_to [picture.campaign.organization, picture.campaign]
    end
  end
end

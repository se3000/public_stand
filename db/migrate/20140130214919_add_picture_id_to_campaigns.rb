class AddPictureIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :pictures, :campaign_id, :integer
  end
end

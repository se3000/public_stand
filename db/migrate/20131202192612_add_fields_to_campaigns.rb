class AddFieldsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :active, :boolean, default: false
  end
end

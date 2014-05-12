class AddFccToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :fcc, :boolean
  end
end

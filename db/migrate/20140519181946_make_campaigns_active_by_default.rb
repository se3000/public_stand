class MakeCampaignsActiveByDefault < ActiveRecord::Migration
  def change
    change_column :campaigns, :active, :boolean, default: true
    execute 'UPDATE campaigns SET active = true'
  end
end

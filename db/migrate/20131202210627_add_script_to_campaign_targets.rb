class AddScriptToCampaignTargets < ActiveRecord::Migration
  def change
    add_column :campaign_targets, :script, :text
  end
end

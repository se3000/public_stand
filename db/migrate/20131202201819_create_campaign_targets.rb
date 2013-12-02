class CreateCampaignTargets < ActiveRecord::Migration
  def change
    create_table :campaign_targets do |t|
      t.integer :campaign_id
      t.integer :target_id

      t.timestamps
    end
  end
end

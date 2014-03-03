class PhoneCallsBelongToCampaignTargets < ActiveRecord::Migration
  def change
    add_column :phone_calls, :campaign_target_id, :integer
  end
end

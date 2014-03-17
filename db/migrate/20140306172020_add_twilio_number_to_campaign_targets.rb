class AddTwilioNumberToCampaignTargets < ActiveRecord::Migration
  def change
    add_column :campaign_targets, :twilio_number, :string
  end
end

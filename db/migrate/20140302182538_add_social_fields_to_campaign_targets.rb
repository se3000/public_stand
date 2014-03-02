class AddSocialFieldsToCampaignTargets < ActiveRecord::Migration
  def change
    add_column :campaign_targets, :twitter_share_text, :string
  end
end

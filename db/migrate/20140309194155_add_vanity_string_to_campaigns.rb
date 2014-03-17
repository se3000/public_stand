class AddVanityStringToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :vanity_string, :string
  end
end

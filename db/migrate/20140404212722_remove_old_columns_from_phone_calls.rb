class RemoveOldColumnsFromPhoneCalls < ActiveRecord::Migration
  def change
    remove_column :phone_calls, :campaign_id
    remove_column :phone_calls, :target_id
  end
end

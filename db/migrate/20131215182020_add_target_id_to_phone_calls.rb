class AddTargetIdToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :target_id, :integer
  end
end

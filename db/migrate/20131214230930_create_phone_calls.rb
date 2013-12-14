class CreatePhoneCalls < ActiveRecord::Migration
  def change
    create_table :phone_calls do |t|
      t.integer :campaign_id
      t.text :twilio_token

      t.timestamps
    end
  end
end

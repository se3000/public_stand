class CreatePhoneCallFeedbacks < ActiveRecord::Migration
  def change
    create_table :phone_call_feedbacks do |t|
      t.integer :phone_call_id
      t.string  :email_address
      t.text    :comments

      t.timestamps
    end
  end
end

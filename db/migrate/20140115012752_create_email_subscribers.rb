class CreateEmailSubscribers < ActiveRecord::Migration
  def change
    create_table :email_subscribers do |t|
      t.string :email_address

      t.timestamps
    end
  end
end

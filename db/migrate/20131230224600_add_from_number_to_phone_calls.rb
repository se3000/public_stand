class AddFromNumberToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :from_number, :string
  end
end

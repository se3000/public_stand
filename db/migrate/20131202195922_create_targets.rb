class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end

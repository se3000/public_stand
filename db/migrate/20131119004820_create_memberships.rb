class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :organization_id, null: false
      t.integer :member_id, null: false

      t.timestamps
    end
  end
end

class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :organization_id, null: false
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

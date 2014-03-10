class AddHostUrlToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :host_url, :string
  end
end

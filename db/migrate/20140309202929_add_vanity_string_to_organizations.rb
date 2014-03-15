class AddVanityStringToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :vanity_string, :string
  end
end

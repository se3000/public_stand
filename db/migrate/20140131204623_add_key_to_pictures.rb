class AddKeyToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :s3_key, :string
  end
end

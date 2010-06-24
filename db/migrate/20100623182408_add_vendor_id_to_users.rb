class AddVendorIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :vendor_id, :integer
  end

  def self.down
    remove_column :users, :vendor_id
  end
end

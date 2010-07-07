class AddStatusToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :status, :string, :default => 'Not Approved'
  end

  def self.down
    remove_column :lists, :status
  end
end

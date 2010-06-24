class RemoveCategoryFromLists < ActiveRecord::Migration
  def self.up
    remove_column :lists, :category_id
  end

  def self.down
    add_column :lists, :category_id, :integer, :null => false
  end
end

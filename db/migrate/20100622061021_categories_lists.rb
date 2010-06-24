class CategoriesLists < ActiveRecord::Migration
  def self.up
    create_table :categories_lists, :id => false do |t|
        t.integer :category_id
        t.integer :list_id
    end
  end

  def self.down
      drop_table :categories_lists
  end
end

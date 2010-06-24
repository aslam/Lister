class AddStateAndCityToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :state_id, :integer
    add_column :addresses, :city_id, :integer

    remove_column :location
  end

  def self.down
    add_column :addresses, :location, :string
    remove_columns :addresses, :state_id, :city_id
  end
end

class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :location
      t.string :name
      t.string :email
      t.string :mobile
      t.string :phone
      t.string :fax
      t.references :list

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end


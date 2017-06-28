class AddLolcationTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table :<%= table_name %> do |t|
      t.float :lolcation_latitude
      t.float :lolcation_longitude
      t.integer :lolcation_id
      t.string :lolcation_address_street
      t.string :lolcation_address_neighborhood
      t.string :lolcation_address_city
      t.string :lolcation_address_state
      t.string :lolcation_address_number
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

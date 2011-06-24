class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :address_type_id, :null => false, :options => "CONSTRAINT fk_address_address_types REFERENCES address_address_types(id)"
      t.integer :person_id, :null => false, :options => "CONSTRAINT fk_address_people REFERENCES people(id)"
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end

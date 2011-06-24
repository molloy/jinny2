class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.integer :phone_type_id, :null => false, :options => "CONSTRAINT fk_phone_phone_types REFERENCES phone_types(id)"
      t.integer :person_id, :null => false, :options => "CONSTRAINT fk_phone_people REFERENCES people(id)"
      t.string :phone_number

      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end

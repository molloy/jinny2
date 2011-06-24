class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :person_type_id, :null => false, :options => "CONSTRAINT fk_people_person_types REFERENCES person_types(id)"
      t.string :given_name
      t.string :middle_name
      t.string :surname
      t.string :native_given_name
      t.string :native_surname

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

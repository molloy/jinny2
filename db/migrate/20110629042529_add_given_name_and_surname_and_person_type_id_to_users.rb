class AddGivenNameAndSurnameAndPersonTypeIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :given_name, :string
    add_column :users, :surname, :string
    add_column :users, :person_type_id, :integer
  end

  def self.down
    remove_column :users, :person_type_id
    remove_column :users, :surname
    remove_column :users, :given_name
  end
end

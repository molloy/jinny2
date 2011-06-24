class AddSsnToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :ssn, :string
  end

  def self.down
    remove_column :people, :ssn
  end
end

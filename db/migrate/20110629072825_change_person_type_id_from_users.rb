class ChangePersonTypeIdFromUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :person_type_id, :integer, :null => false, :default => 0
  end

  def self.down
    change_column :users, :person_type_id, :integer, :null => true
  end
end

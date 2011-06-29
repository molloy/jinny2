class ChangePersonIdFromUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :person_id, :integer, :null => true, :options => "CONSTRAINT fk_user_person_id REFERENCES people(id)"
  end

  def self.down
    change_column :users, :person_id, :integer, :null => false, :options => "CONSTRAINT fk_user_person_id REFERENCES people(id)"
  end
end

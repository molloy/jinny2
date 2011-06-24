class AddDegreeProgramIdToPerson < ActiveRecord::Migration
  def self.up
    remove_column :people, :degree_enrolled
    add_column :people, :degree_program_id, :integer
  end

  def self.down
    remove_column :people, :degree_program_id
    add_column :people, :degree_enrolled, :integer
  end
end

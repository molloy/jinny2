class AddDepartmentIdToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :department_id, :integer
    remove_column :people, :department
  end

  def self.down
    remove_column :people, :department_id
    add_column :people, :department, :string
  end
end

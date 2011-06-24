class AddDepartmentIdToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :department_id, :integer
    remove_column :courses, :major_id
  end

  def self.down
    remove_column :courses, :department_id
    add_column :courses, :major_id, :integer
  end
end

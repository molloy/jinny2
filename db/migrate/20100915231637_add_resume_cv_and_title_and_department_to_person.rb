class AddResumeCvAndTitleAndDepartmentToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :resume_cv, :binary
    add_column :people, :title, :string
    add_column :people, :department, :string
  end

  def self.down
    remove_column :people, :department
    remove_column :people, :title
    remove_column :people, :resume_cv
  end
end

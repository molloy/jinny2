class AddInstructorToCourseOffering < ActiveRecord::Migration
  def self.up
    add_column :course_offerings, :instructor, :integer, :null => false, :options => "CONSTRAINT fk_course_offering_instructor REFERENCES people(id)"
  end

  def self.down
    remove_column :course_offerings, :instructor
  end
end

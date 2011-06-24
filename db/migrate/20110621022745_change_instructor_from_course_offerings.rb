class ChangeInstructorFromCourseOfferings < ActiveRecord::Migration
  def self.up
    change_column :course_offerings, :instructor, :integer, :null => true, :options => "CONSTRAINT fk_course_offering_instructor REFERENCES people(id)"
  end

  def self.down
    change_column :course_offerings, :instructor, :integer, :null => false, :options => "CONSTRAINT fk_course_offering_instructor REFERENCES people(id)"
  end
end

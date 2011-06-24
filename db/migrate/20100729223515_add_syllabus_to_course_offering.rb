class AddSyllabusToCourseOffering < ActiveRecord::Migration
  def self.up
    add_column :course_offerings, :syllabus, :binary
  end

  def self.down
    remove_column :course_offerings, :syllabus
  end
end

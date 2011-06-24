class AddSyllabusFileNameAndSyllabusFileSizeAndSyllabusUpdatedAtToCourseOfferings < ActiveRecord::Migration
  def self.up
    add_column :course_offerings, :syllabus_file_name, :string
    add_column :course_offerings, :syllabus_file_size, :integer
    add_column :course_offerings, :syllabus_updated_at, :datetime
    remove_column :course_offerings, :syllabus
  end

  def self.down
    remove_column :course_offerings, :syllabus_updated_at
    remove_column :course_offerings, :syllabus_file_size
    remove_column :course_offerings, :syllabus_file_name
    add_column :course_offerings, :syllabus, :binary
  end
end

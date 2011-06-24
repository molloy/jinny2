class AddPictureContentTypeToPerson < ActiveRecord::Migration
  def self.up
    remove_column :people, :picture
    add_column :people, :picture_content_type, :string
    add_column :people, :picture, :binary, :limit => 10.megabytes

    remove_column :people, :resume_cv
    add_column :people, :resume_cv, :binary, :limit => 10.megabytes
    add_column :people, :resume_cv_content_type, :string

    remove_column :course_offerings, :syllabus
    add_column :course_offerings, :syllabus, :binary, :limit => 10.megabytes
    add_column :course_offerings, :syllabus_content_type, :string
  end

  def self.down
    remove_column :people, :picture_content_type
    remove_column :people, :picture
    add_column :people, :picture, :binary

    remove_column :people, :resume_cv_content_type
    remove_column :people, :resume_cv
    add_column :people, :resume_cv, :binary
    
    remove_column :course_offerings, :syllabus_content_type
    remove_column :course_offerings, :syllabus
    add_column :course_offerings, :syllabus, :binary
  end
end

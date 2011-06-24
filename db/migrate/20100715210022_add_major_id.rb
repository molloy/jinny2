class AddMajorId < ActiveRecord::Migration
  def self.up
    add_column :courses, :major_id, :integer, :null => false, :options => "CONSTRAINT fk_course_major REFERENCES majors(id)"
  end

  def self.down
    remove_column :courses, :major_id
  end
end

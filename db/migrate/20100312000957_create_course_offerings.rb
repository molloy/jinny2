class CreateCourseOfferings < ActiveRecord::Migration
  def self.up
    create_table :course_offerings do |t|
      t.integer :course_id, :null => false, :options => "CONSTRAINT fk_course_offering_courses REFERENCES courses(id)"
      t.integer :year, :null => false
      t.integer :term_type_id, :null => false, :options => "CONSTRAINT fk_course_offering_term_types REFERENCES term_types(id)"

      t.timestamps
    end
  end

  def self.down
    drop_table :course_offerings
  end
end

class CreateCourseTakens < ActiveRecord::Migration
  def self.up
    create_table :course_takens do |t|
      t.integer :person_id, :null => false, :options => "CONSTRAINT fk_course_taken_people REFERENCES people(id)"
      t.integer :course_offering_id, :null => false, :options => "CONSTRAINT fk_course_taken_course_offerings REFERENCES course_oferings(id)"
      t.integer :course_taken_status_id, :null => false, :options => "CONSTRAINT fk_course_taken_course_taken_statuses REFERENCES course_taken_statuses(id)"
      t.integer :grade_type_id, :null => false, :options => "CONSTRAINT fk_course_taken_grade_types REFERENCES grade_types(id)"
      t.text :evaluation

      t.timestamps
    end
  end

  def self.down
    drop_table :course_takens
  end
end

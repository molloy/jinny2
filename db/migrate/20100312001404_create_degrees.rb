class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.integer :person_id, :null => false, :options => "CONSTRAINT fk_degree_grade_types REFERENCES people(id)"
      t.integer :major_id, :null => false, :options => "CONSTRAINT fk_degree_grade_types REFERENCES majors(id)"
      t.string :institution
      t.boolean :earned
      t.date :earned_date

      t.timestamps
    end
  end

  def self.down
    drop_table :degrees
  end
end

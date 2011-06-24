class CreateCourseTakenStatuses < ActiveRecord::Migration
  def self.up
    create_table :course_taken_statuses do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :course_taken_statuses
  end
end

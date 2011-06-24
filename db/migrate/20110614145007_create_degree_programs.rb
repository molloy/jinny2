class CreateDegreePrograms < ActiveRecord::Migration
  def self.up
    create_table :degree_programs do |t|
      t.string :title
      t.integer :major_id
      t.integer :degree_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :degree_programs
  end
end

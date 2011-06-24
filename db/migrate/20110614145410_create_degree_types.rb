class CreateDegreeTypes < ActiveRecord::Migration
  def self.up
    create_table :degree_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :degree_types
  end
end

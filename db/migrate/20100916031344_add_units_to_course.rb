class AddUnitsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :units, :integer
  end

  def self.down
    remove_column :courses, :units
  end
end

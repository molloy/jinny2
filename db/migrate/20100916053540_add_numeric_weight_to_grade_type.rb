class AddNumericWeightToGradeType < ActiveRecord::Migration
  def self.up
    remove_column :grade_types, :numeric_weight
    add_column :grade_types, :numeric_weight, :float
  end

  def self.down
    remove_column :grade_types, :numeric_weight
    add_column :grade_types, :numeric_weight, :decimal
  end
end

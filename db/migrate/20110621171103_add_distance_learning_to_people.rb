class AddDistanceLearningToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :distance_learning, :boolean
  end

  def self.down
    remove_column :people, :distance_learning
  end
end

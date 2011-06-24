class AddInternationalAndCorrespondenceToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :international, :boolean
    add_column :people, :correspondence, :boolean
  end

  def self.down
    remove_column :people, :correspondence
    remove_column :people, :international
  end
end

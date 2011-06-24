class AddDobAndEmailAndGenderAndPictureAndDegreeEnrolledAndDateEnrolledAndDateGraduatedToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :dob, :date
    add_column :people, :email, :string
    add_column :people, :picture, :binary
    add_column :people, :degree_enrolled, :integer
    add_column :people, :date_enrolled, :date
    add_column :people, :date_graduated, :date
  end

  def self.down
    remove_column :people, :date_graduated
    remove_column :people, :date_enrolled
    remove_column :people, :degree_enrolled
    remove_column :people, :picture
    remove_column :people, :email
    remove_column :people, :dob
  end
end

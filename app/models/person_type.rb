class PersonType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.student
    return @person_type_student if defined?(@person_type_student)
    @person_type_student = where(:name => "Student").first
  end
  
  def self.administrator
    return @person_type_administrator if defined?(@person_type_administrator)
    @person_type_administrator = where(:name => "Administrator").first
  end

  def self.faculty
    return @person_type_faculty if defined?(@person_type_faculty)
    @person_type_faculty = where(:name => "Faculty").first
  end
  
  def self.all_faculty_for_select
    return Person.where(:person_type_id => faculty.id).all.order('last_name, first_name').collect { |p| p.last_name_first }
  end
end

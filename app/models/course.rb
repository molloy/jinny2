class Course < ActiveRecord::Base
  has_many :course_offerings
  
  belongs_to :department
  
  accepts_nested_attributes_for :course_offerings, :allow_destroy => true
  
  validates_presence_of :course_number, :name, :department, :units
  validates_numericality_of :units

  def course_number_and_name
    return read_attribute(:course_number) + " - " + read_attribute(:name)
  end
  
  def department_autocomplete
    department.name unless department.nil?
  end
  
  def department_autocomplete=(val)
  end

  cattr_reader :per_page
  @@per_page = 10
end

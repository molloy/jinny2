class Person < ActiveRecord::Base
  has_many :addresses, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :course_takens, :dependent => :destroy
  # has_many :course_offerings, :class_name => "CourseOffering", :finder_sql => 'SELECT co.*  FROM course_offerings WHERE co.instructor = #{id}'
  has_many :course_offerings, :foreign_key => "instructor"
  
  has_one :user, :dependent => :destroy
  
  belongs_to :degree_program
  belongs_to :department

  accepts_nested_attributes_for :addresses, :phones, :course_takens, :course_offerings, :allow_destroy => true
  
  validates_presence_of :person_type_id, :given_name, :surname
  
  scope :course_taught, lambda {|the_course_id| where{id.in(CourseOffering.where{course_id.eq the_course_id}.select{instructor})}}
  search_methods :course_taught

  def full_name
    return read_attribute(:given_name) + " " + read_attribute(:surname)
  end
  
  def last_name_first
    return read_attribute(:surname) + ", " + read_attribute(:given_name)
  end

  def dob_formatted
    return dob
  end
  
  def dob_formatted=(dob_str)
    self.dob = Date.strptime(dob_str, '%m/%d/%Y')
  end

  def date_enrolled_formatted
    return date_enrolled
  end
  
  def date_enrolled_formatted=(date_enrolled_str)
    self.date_enrolled = Date.strptime(date_enrolled_str, '%m/%d/%Y')
  end
  
  def date_graduated_formatted
    return date_graduated
  end
  
  def date_graduated_formatted=(date_graduated_str)
    self.date_graduated = Date.strptime(date_graduated_str, '%m/%d/%Y')
  end

  def picture_file=(input_file)
    self.picture = input_file.read
    self.picture_content_type = input_file.content_type.chomp
  end
  
  def picture_file_name
    return full_name + "." + get_file_ext_from_content_type(read_attribute(:picture_content_type))
  end
  
  def resume_cv_file=(input_file)
    self.resume_cv = input_file.read
    self.resume_cv_content_type = input_file.content_type.chomp
  end

  def resume_cv_file_name
    return full_name + "." + get_file_ext_from_content_type(read_attribute(:resume_cv_content_type))
  end

  def degree_program_autocomplete
    degree_program.title unless degree_program.nil?
  end
  
  def degree_program_autocomplete=(val)
  end

  def department_autocomplete
    department.name unless department.nil?
  end
  
  def department_autocomplete=(val)
  end
  
  cattr_reader :per_page
  @@per_page = 10
end

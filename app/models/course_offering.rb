class CourseOffering < ActiveRecord::Base
  has_many :course_takens, :dependent => :destroy

  belongs_to :course
  belongs_to :term_type
  belongs_to :instructor_person, :class_name => 'Person', :foreign_key => 'instructor'
  
  accepts_nested_attributes_for :course_takens, :allow_destroy => true
  
  validates_presence_of :course_id, :year, :term_type_id
  validates_numericality_of :year

  has_attached_file :syllabus
  
  def display_name
    return year.to_s + ' ' + TermType.find(read_attribute(:term_type_id)).name + ' - ' + course_number_and_name
  end
  
  def course_number_and_name
    Course.find(read_attribute(:course_id)).course_number_and_name
  end

  def course_number
    Course.find(read_attribute(:course_id)).course_number
  end
  
  def course_autocomplete
    course.course_number_and_name unless course.nil?
  end
  
  def course_autocomplete=(val)
  end

  def instructor_autocomplete
    instructor_person.full_name unless instructor_person.nil?
  end
  
  def instructor_autocomplete=(val)
  end
end

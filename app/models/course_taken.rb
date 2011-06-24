class CourseTaken < ActiveRecord::Base
  before_create :set_course_offering
  
  belongs_to :person
  belongs_to :course_offering
  belongs_to :course_taken_status
  belongs_to :grade_type

  validates_presence_of :course_id, :term_type_id, :year
  
  def set_course_offering
    if course_offering.nil?
      self.course_offering = CourseOffering.find_or_create_by_course_id_and_year_and_term_type_id(self.course_id, self.year, self.term_type_id)
    end
  end
  
  def year
    course_offering.nil? ? @year : course_offering.year
  end
  
  def year=(val)
    @year = val
  end
  
  def course_id
    course_offering.nil? ? @course_id : course_offering.course.id
  end
  
  def course_id=(val)
    @course_id = val
  end
  
  def term_type_id
    course_offering.nil? ? @term_type_id : course_offering.term_type.id
  end
  
  def term_type_id=(val)
    @term_type_id = val
  end

  def course_autocomplete
    course_offering.course.course_number_and_name unless course_offering.nil?
  end
  
  def course_autocomplete=(val)
  end
  
  def course
    course_offering.course.course_number_and_name unless course_offering.nil?
  end

  def course=(val)
  end
  
  def term_type
    course_offering.term_type.name unless course_offering.nil?
  end

  def term_type=(val)
  end
end

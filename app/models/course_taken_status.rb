class CourseTakenStatus < ActiveRecord::Base
  has_many :course_takens
  validates_uniqueness_of :name

  def self.completed
    return @course_taken_status_completed if defined?(@course_taken_status_completed)
    @course_taken_status_completed = where(:name => "Completed").first
  end
  
  def self.withdrawn
    return @course_taken_status_withdrawn if defined?(@course_taken_status_withdrawn)
    @course_taken_status_withdrawn = where(:name => "Withdrawn").first
  end
  
  def self.incomplete
    return @course_taken_status_incomplete if defined?(@course_taken_status_incomplete)
    @course_taken_status_incomplete = where(:name => "Incomplete").first
  end
  
  def self.attending
    return @course_taken_status_attending if defined?(@course_taken_status_attending)
    @course_taken_status_attending = where(:name => "Attending").first
  end
  
  def self.registered
    return @course_taken_status_registered if defined?(@course_taken_status_registered)
    @course_taken_status_registered = where(:name => "Registered").first
  end
  
end

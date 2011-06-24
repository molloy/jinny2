class GradeType < ActiveRecord::Base
  validates_presence_of :letter_grade
  validates_numericality_of :numeric_weight
  
  def name
    self.letter_grade
  end
  
  def name=(val)
    self.letter_grade = val
  end
end

class Major < ActiveRecord::Base
  has_many :degree_programs
  validates_uniqueness_of :name
end

class DegreeType < ActiveRecord::Base
  has_many :degree_programs
end

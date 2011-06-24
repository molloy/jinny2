class DegreeProgram < ActiveRecord::Base
  belongs_to :degree_type
  belongs_to :major
  has_many :people
end

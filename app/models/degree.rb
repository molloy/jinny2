class Degree < ActiveRecord::Base
  belongs_to :person
  belongs_to :major
  validates_uniqueness_of :name
end

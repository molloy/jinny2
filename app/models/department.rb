class Department < ActiveRecord::Base
  has_many :person
  validates_uniqueness_of :name
end

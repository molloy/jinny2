class Degree < ActiveRecord::Base
  belongs_to :person
  belongs_to :major
end

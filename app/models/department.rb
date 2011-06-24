class Department < ActiveRecord::Base
  has_many :person
end

class User < ActiveRecord::Base
  belongs_to :person
  belongs_to :person_type
  
  acts_as_authentic do |c|
  end
end
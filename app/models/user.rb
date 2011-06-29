class User < ActiveRecord::Base
  belongs_to :person
  belongs_to :person_type
  
  acts_as_authentic do |c|
  end
  
  def full_name
    self.given_name << ' ' << self.surname
  end
end
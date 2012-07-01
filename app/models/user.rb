class User < ActiveRecord::Base
  belongs_to :person
  belongs_to :person_type

  validates_presence_of :person_type, :email
  validates_uniqueness_of :email
  
  acts_as_authentic do |c|
  end
  
  def full_name
    (self.given_name.nil? ? '' : self.given_name)  << ' ' << (self.surname.nil? ? '' : self.surname)
    # self.given_name  << ' ' << self.surname
  end
end
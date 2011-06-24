class User < ActiveRecord::Base
  belongs_to :person
  
  acts_as_authentic do |c|
  end
end
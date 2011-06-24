class PhoneType < ActiveRecord::Base
  validates_presence_of :name

  def self.mobile
    return @phone_type_mobile if defined?(@phone_type_mobile)
    @phone_type_mobile = PhoneType.where(:name => "Mobile").first
  end

  def self.home
    return @phone_type_home if defined?(@phone_type_home)
    @phone_type_home = PhoneType.where(:name => "Home").first
  end

  def self.work
    return @phone_type_work if defined?(@phone_type_work)
    @phone_type_work = PhoneType.where(:name => "Work").first
  end
end

class AddressType < ActiveRecord::Base
  validates_presence_of :name

  def self.home
    return @address_type_home if defined?(@address_type_home)
    @address_type_home = where(:name => "Home").first
  end

  def self.mailing
    return @address_type_mailing if defined?(@address_type_mailing)
    @address_type_mailing = where(:name => "Mailing").first
  end
end

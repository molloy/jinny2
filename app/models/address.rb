class Address < ActiveRecord::Base
  belongs_to :person
  belongs_to :address_type

  def display_text
    return AddressType.find(read_attribute(:address_type_id)).name << ": " << read_attribute(:address_1) << " " << read_attribute(:city) << ", " << read_attribute(:province) << " " << read_attribute(:postal_code)
  end
end

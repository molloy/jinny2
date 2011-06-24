module AddressTypesHelper
  def address_type_home
    return @address_type_home if defined?(@address_type_home)
    @address_type_home = AddressType.home
  end

  def address_type_mailing
    return @address_type_mailing if defined?(@address_type_mailing)
    @address_type_mailing = AddressType.mailing
  end
end

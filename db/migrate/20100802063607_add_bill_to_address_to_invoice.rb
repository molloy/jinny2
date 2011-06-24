class AddBillToAddressToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :bill_to_address, :integer
  end

  def self.down
    remove_column :invoices, :bill_to_address
  end
end

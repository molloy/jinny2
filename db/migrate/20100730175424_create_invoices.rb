class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :invoice_number, :null => false
      t.integer :bill_to, :null => false, :options => "CONSTRAINT fk_invoices_people REFERENCES people(id)"
      t.string :bill_to_address_1
      t.string :bill_to_address_2
      t.string :bill_to_address_3
      t.string :bill_to_city
      t.string :bill_to_province
      t.string :bill_to_postal_code
      t.string :bill_to_country
      t.string :remit_to
      t.string :remit_to_address_1
      t.string :remit_to_address_2
      t.string :remit_to_address_3
      t.string :remit_to_city
      t.string :remit_to_province
      t.string :remit_to_postal_code
      t.string :remit_to_country
      t.date :invoice_date
      t.integer :invoice_term
      t.decimal :invoice_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end

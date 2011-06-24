class CreateInvoiceItems < ActiveRecord::Migration
  def self.up
    create_table :invoice_items do |t|
      t.integer :invoice_id, :null => false, :options => "CONSTRAINT fk_invoice_items_invoices REFERENCES invoices(id)"
      t.string :name, :null => false
      t.string :description
      t.decimal :unit_price, :null => false
      t.integer :quantity, :null => false
      t.decimal :discount
      t.decimal :total, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_items
  end
end

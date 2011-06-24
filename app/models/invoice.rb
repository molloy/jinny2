class Invoice < ActiveRecord::Base
  belongs_to :bill_to_person, :class_name => "Person", :foreign_key => "bill_to"
  has_many :invoice_items, :dependent => :destroy
  accepts_nested_attributes_for :invoice_items, :allow_destroy => true
end

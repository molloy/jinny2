require "date"
module InvoicesHelper
  def set_bill_to(name)
    button_to_function name do |page|
      page << %{
        var selected_bill_to_control = $("selected_bill_to");
        if (selected_bill_to_control) {
          var selected_bill_to_id = $F("selected_bill_to");
          var selected_bill_to_text = $$("#selected_bill_to option[value=" + selected_bill_to_id + "]")[0].text;
          var invoice_bill_to_controls = $('invoice_bill_to');
          invoice_bill_to_controls.remove(invoice_bill_to_controls.descendants());
          invoice_bill_to_controls.update(new Element('option', {value: selected_bill_to_id}).update(selected_bill_to_text));
        }
      }
    end
  end

  def add_invoice_item_link(name, form)
    link_to_function name do |page|
      invoice_item = render(:partial => 'invoice_item', :locals => { :ii => form, :invoice_item => InvoiceItem.new } )
      page << %{
        var new_invoice_item_id = "invoice_items_attributes_" + new Date().getTime();
        var new_invoice_item_id_brackets = "invoice_items_attributes\]\[" + new Date().getTime() + "\]";
        $('invoice_items').insert({ bottom: "#{ escape_javascript invoice_item }".replace(/invoice_items_attributes\\]\\[\\d+\\]/g, new_invoice_item_id_brackets).replace(/invoice_items_attributes_\\d+/g, new_invoice_item_id) });
      }
    end
  end
end

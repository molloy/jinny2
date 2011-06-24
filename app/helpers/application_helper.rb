# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def search_show_all_button(model_name, search_url)
    inputId = 'search' << model_name << 'search_show_all_button';
		inputHTML = tag('input', { :id => inputId, :type => 'button', :value => 'Show All' })
    url_for_path = url_for(search_url).gsub(/\?/, '.js?')
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('##{inputId}').click(function() {
    	  $('#search_result_header').hide(); $('#search_result_panel').hide(); $('#search_result_loading').show();
    		$.get('#{url_for_path}', function() {
    		  $('#search_result_loading').hide();
    		});
      });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end

  def remove_link_unless_new_record(fields)
    unless fields.object.nil?
      unless fields.object.new_record?
        out = ''
        out << fields.hidden_field(:_delete)
        out << link_to_function("remove", "$(this).up('.#{fields.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
        out
      end
    end
  end
  
  def sanitized_object_name(object_name)
    object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/,"_").sub(/_$/,"")
  end

  def sanitized_method_name(method_name)
    method_name.sub(/\?$/, "")
  end

  def form_tag_id(object_name, method_name)
    "#{sanitized_object_name(object_name.to_s)}_#{sanitized_method_name(method_name.to_s)}"
  end
    
  def get_years_with_selected(selected = nil)
    a = (5.years.ago.year..5.years.from_now.year).to_a
    unless selected.nil?
      a << selected
    end
    return a.uniq.sort;
  end
  
  def search_method_select_tag(field_name, options = ["equals", "starts with", "ends with", "contains", "between"], selected = "contains")
    field_name = field_name.to_s
    if (field_name =~ /_conditionoperator$/).nil?
      field_name << '_conditionoperator'
      logger.debug(field_name)
    end
    select_tag field_name, options_for_select(options, selected)
  end
end

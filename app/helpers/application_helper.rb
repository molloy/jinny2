# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def new_button(new_url)
    inputHTML = tag('input', { :class => 'new_button', :type => 'button', :value => 'New' })
    url_for_path = url_for(new_url)
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	// new button
        $(document).ready(function() {
        	$('.new_button').click(function() {
        		$('#j-center').empty();
        		$('#j-loading').show();
            $.getScript('#{url_for_path}', function() { $('#j-loading').hide(); });
          });
        });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end

  def back_button(back_url)
    inputHTML = tag('input', { :class => 'back_button', :type => 'button', :value => 'Back' })
    url_for_path = url_for(back_url)
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
      //  back button
      $('.back_button').click(function() {
        $('#j-center').empty(); $('#j-loading').show();
        $.getScript('#{url_for_path}', function() { $('#j-loading').hide(); });
      });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end

  def search_show_all_button(model_name, search_url)
    inputId = 'search' << model_name << 'search_show_all_button';
		inputHTML = tag('input', { :id => inputId, :type => 'button', :value => 'Show All' })
    url_for_path = url_for(search_url)
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
      $('##{inputId}').click(function() {
        $('#search_result_header').hide(); $('#search_result_panel').hide(); $('#search_result_loading').show();
        $.getScript('#{url_for_path}', function() { $('#search_result_loading').hide(); });
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
    
  def params_as_hidden_fields(search_field)
    inputHTML = ''
    unless params[search_field].nil?
      params[search_field].each_pair do |key, val|
        inputHTML << hidden_field_tag('search[' + key + ']', val)
      end
    end
    raw(inputHTML);
  end
end

require "date"
module PeopleHelper
  def add_course_taken_link(name, form)
    link_to_function name do |page|
      course_taken = render(:partial => 'course_taken', :locals => { :ct => form, :course_taken => CourseTaken.new } )
      page << %{
        var selected_course_offering_control = $("selected_course_offering");
        if (selected_course_offering_control) {
          var new_course_taken_id = "course_takens_attributes_" + new Date().getTime();
          var new_course_taken_id_brackets = "course_takens_attributes\]\[" + new Date().getTime() + "\]";
          var selected_course_offering_id = $F("selected_course_offering");
          var selected_course_offering_text = $$("#selected_course_offering option[value=" + selected_course_offering_id + "]")[0].text;
          $('course_takens').insert({ bottom: "#{ escape_javascript course_taken }".replace(/course_takens_attributes\\]\\[\\d+\\]/g, new_course_taken_id_brackets).replace(/course_takens_attributes_\\d+/g, new_course_taken_id).replace(/to_be_replaced_with_course_offering_id/g, selected_course_offering_id).replace(/to_be_replaced_with_course_offering_text/g, selected_course_offering_text) });
        } else {
          alert("Please filter by year first.");
        }
      }
    end
  end
  
  def search_person_show_all_button
		inputHTML = tag('input', { :id => 'search_show_all_button', :type => 'button', :value => 'Show All' })
    url_for_people_path = url_for(people_path(:search => {'show_all' => 'true', 'person_type_id_equals' => params[:person_type]}, :person_type => params[:person_type])).gsub(/\/people\?/, 'people.js?')
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#search_show_all_button').click(function() {
    	  $('#search_result_header').hide(); $('#search_result_panel').hide(); $('#search_result_loading').show();
    		$.get('#{url_for_people_path}', function() {
    		  $('#search_result_loading').hide();
    		});
      });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end

  def add_course_taken_button(form)
    inputHTML = tag('input', { :id => 'add_course_taken', :type => 'button', :value => 'Add'})
    course_taken_partial = escape_javascript( render(:partial => "course_taken", :locals => {:f => form}) )
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#add_course_taken').click(function() {
    		var new_index = new Date() * 1 + parseInt(Math.random()*100000);
    		var new_course_taken_html = '#{course_taken_partial}';
    		var new_course_taken_name = 'course\[course_takens_attributes\]\[' + new_index + '\]';
    		var new_course_taken_id = 'course_course_takens_attributes_' + new_index;
    		new_course_taken_html = new_course_taken_html
    			.replace(/course\\[course_takens_attributes\\]\\[\\d+\\]/g, new_course_taken_name)
    			.replace(/course_course_takens_attributes_\\d+/g, new_course_taken_id);
    		$('#nested-models').append(new_course_taken_html);
    	});
    });
    </script>
    HEREDOC
    
    raw(inputHTML) << raw(scriptHTML);
  end

  def delete_course_taken_button
    content = <<-HEREDOC
    <li class="select optional">
      <label>&nbsp;</label>
      <input type="button" value="Delete" />
    </li>
    HEREDOC
    raw(content)
  end

  def person_back_button
    inputHTML = tag('input', { :class => 'person_back_button', :type => 'button', :value => 'Back' })
    url_for_people_path = url_for(people_path(:search => params[:search], :person_type => params[:person_type])).gsub(/\/people\?/, 'people.js?')

    raw(inputHTML);
  end
end

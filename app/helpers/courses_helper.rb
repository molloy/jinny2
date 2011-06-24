module CoursesHelper
  def search_course_show_all_button
		inputHTML = tag('input', { :id => 'search_show_all_button', :type => 'button', :value => 'Show All' })
    url_for_courses_path = url_for(courses_path(:search => {'show_all' => 'true'})).gsub(/\/courses\?/, 'courses.js?')
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#search_show_all_button').click(function() {
    	  $('#search_result_header').hide(); $('#search_result_panel').hide(); $('#search_result_loading').show();
    		$.get('#{url_for_courses_path}', function() {
    		  $('#search_result_loading').hide();
    		});
      });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end
  
  def course_back_button
    inputHTML = tag('input', { :class => 'course_back_button', :type => 'button', :value => 'Back' })
    url_for_courses_path = url_for(courses_path(:search => params[:search])).gsub(/\/courses\?/, 'courses.js?')

    raw(inputHTML);
  end
    
  def add_course_offering_button(form)
    inputHTML = tag('input', { :id => 'add_course_offering', :type => 'button', :value => 'Add'})
    course_offering_partial = escape_javascript( render(:partial => "course_offering", :locals => {:f => form}) )
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#add_course_offering').click(function() {
    		var new_index = new Date() * 1 + parseInt(Math.random()*100000);
    		var new_course_offering_html = '#{course_offering_partial}';
    		var new_course_offering_name = 'course\[course_offerings_attributes\]\[' + new_index + '\]';
    		var new_course_offering_id = 'course_course_offerings_attributes_' + new_index;
    		new_course_offering_html = new_course_offering_html
    			.replace(/course\\[course_offerings_attributes\\]\\[\\d+\\]/g, new_course_offering_name)
    			.replace(/course_course_offerings_attributes_\\d+/g, new_course_offering_id);
    		$('#nested-models').append(new_course_offering_html);
    	});
    });
    </script>
    HEREDOC
    
    raw(inputHTML) << raw(scriptHTML);
  end
  
  def delete_course_offering_button
    content = <<-HEREDOC
    <li class="select optional">
      <label>&nbsp;</label>
      <input type="button" value="Delete" />
    </li>
    HEREDOC
    raw(content)
  end
end

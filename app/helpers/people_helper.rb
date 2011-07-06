module PeopleHelper
  def add_course_taken_button(form)
    inputHTML = tag('input', { :id => 'add_course_taken', :type => 'button', :value => 'Add'})
    course_taken_partial = escape_javascript( render(:partial => "course_taken", :locals => {:f => form}) )
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#add_course_taken').click(function() {
    		var new_index = new Date() * 1 + parseInt(Math.random()*100000);
    		var new_course_taken_html = '#{course_taken_partial}';
    		var new_course_taken_name = 'person\[course_takens_attributes\]\[' + new_index + '\]';
    		var new_course_taken_id = 'person_course_takens_attributes_' + new_index;
    		new_course_taken_html = new_course_taken_html
    			.replace(/person\\[course_takens_attributes\\]\\[\\d+\\]/g, new_course_taken_name)
    			.replace(/person_course_takens_attributes_\\d+/g, new_course_taken_id);
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
end

module UsersHelper
  def search_user_show_all_button
		inputHTML = tag('input', { :id => 'search_show_all_button', :type => 'button', :value => 'Show All' })
    url_for_users_path = url_for(users_path(:search => {'show_all' => 'true'})).gsub(/\/users\?/, 'users.js?')
    scriptHTML = <<-HEREDOC
    <script>
    $(document).ready(function() {
    	$('#search_show_all_button').click(function() {
    	  $('#search_result_header').hide(); $('#search_result_panel').hide(); $('#search_result_loading').show();
    		$.get('#{url_for_users_path}', function() {
    		  $('#search_result_loading').hide();
    		});
      });
    });
    </script>      
    HEREDOC

    raw(inputHTML) << raw(scriptHTML);
  end

  def user_back_button
    inputHTML = tag('input', { :class => 'user_back_button', :type => 'button', :value => 'Back' })
    url_for_users_path = url_for(users_path(:search => params[:search])).gsub(/\/users\?/, 'users.js?')

    raw(inputHTML);
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :is_student, :is_administrator

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def search_by_meta(model_name)
    # clean params
    old_params_search = params[:search]
    params[:search].delete_if { |key, value| (value.nil? || value.blank?) } unless params[:search].nil? || params[:search].empty?
    
    # check to see if params are there
    unless params[:search].nil? || params[:search].empty?
      # store old "show_all"
      show_all = params[:search]['show_all']
      params[:search].delete('show_all')
      
      @search = model_name.to_s.classify.constantize.search(params[:search])

      unless show_all.nil? || !show_all
        params[:search]['show_all'] = show_all
      end

      return @search
    else
      return nil
    end
  end

  def search_condition_parameters
    search_condition_params = [ "" ]
    search_conditions = search_condition_params[0]
    
    params.each do |key, value|
      compare_result = key =~ /_selected/
      
      unless compare_result.nil?
        field_name = key[0, compare_result]
        search_selected = value
        search_op = params[field_name + "_conditionoperator"]
        search_value = params[field_name]
        search_value_from = params[field_name + "_from"]
        search_value_to = params[field_name + "_to"]
        
        if (!search_selected.blank? && !search_value.blank?) || (search_op == "between" && (!search_value_from.blank? && !search_value_to.blank?))
          search_operator = case search_op
            when "equals" then " = "
            when "starts with" then " like "
            when "ends with" then " like "
            when "contains" then " like "
            when "between" then " between ? and "
          end
          
          search_param_value = case search_op
            when "equals" then search_value
            when "starts with" then search_value + "%"
            when "ends with" then "%" + search_value
            when "contains" then "%" + search_value + "%"
          end
          logger.debug "search_operator"
          logger.debug search_operator
          
          search_conditions = search_condition_params[0] 
          unless search_conditions.blank?
            search_conditions << " and "
          end
          
          search_conditions << field_name + search_operator + "?"
          search_condition_params[0] = search_conditions
          if (search_op == "between") then
            search_condition_params[search_condition_params.length] = search_value_from
            search_condition_params[search_condition_params.length] = search_value_to
          else
            search_condition_params[search_condition_params.length] = search_param_value
          end
        end
      end
    end
    
    return search_condition_params
  end

  def search_person_parameters(search_name)
    search_condition_params = [ "" ]
    search_conditions = search_condition_params[0]

    unless search_name.blank?
      names = search_name.split(" ")
      
      names.each do |name|
        search_conditions = search_condition_params[0] 
        unless search_conditions.blank?
          search_conditions << " or "
        end

        search_conditions << 'given_name = ? or middle_name = ? or surname = ?'
        search_condition_params[0] = search_conditions
        search_condition_params[search_condition_params.length] = name
        search_condition_params[search_condition_params.length] = name
        search_condition_params[search_condition_params.length] = name
      end
    end
    
    return search_condition_params
  end

  private
    def is_student
      return current_user.person_type_id == PersonType.student.id
    end
  
    def is_administrator
      return current_user.person_type_id == PersonType.administrator.id
    end
  
    def course_taken_status_attending
      return @course_taken_status_attending if defined?(@course_taken_status_attending)
      @course_taken_status_attending = CourseTakenStatus.find_by_name("Attending")
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end

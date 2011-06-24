module CourseOfferingsHelper
  def course_offerings_search_result_header_link(label, column)
    current_sort = params[:search]['meta_sort']
    direction = '.asc'
    unless current_sort.nil?
      logger.debug current_sort
      if current_sort.start_with?((column + '.'))
        if current_sort.end_with?('.asc')
          direction = '.desc'
        end
      end
    end
    
    new_sort_param = column << direction
    new_search_params = params[:search].dup
    new_search_params['meta_sort'] = new_sort_param
    logger.debug params[:search]
    
  	link_to label, course_offerings_path(:search => new_search_params), :remote => true
  end
end

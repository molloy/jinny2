class CoursesController < ApplicationController
  before_filter :require_user, :load_search_params
  
  autocomplete :department_name, { :department => [:name] }, :display_value => :name, :full => true
  autocomplete :person_fullname, { :person => [:given_name, :surname] }, :display_value => :full_name, :where_filter => ('person_type_id = ' + PersonType.faculty.id.to_s), :full => true
  
  def load_search_params
    @search = search_by_meta :course  
  end

  # GET /courses
  # GET /courses.xml
  def index
    if @search.nil?
      logger.debug 'hello'
      @search = Course.search(params[:search])
      @courses = nil
    else
      @search.meta_sort = "course_number.asc" if @search.meta_sort.nil?
      @courses = @search.paginate(:page => params[:page])
    end
  end
  
  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new
  end
  
  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end
  
  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    
    if @search.nil?
      @search = Course.search(params[:search])
    end

    if @course.save
      flash[:notice] = 'Course was successfully created.'
      @courses = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(courses_path(:search => params[:search]))
    end
  end
  
  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])
    
    if @course.update_attributes(params[:course])
      flash[:notice] = 'Course was successfully updated.'
      @courses = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(courses_path(:search => params[:search]))
    end
  end
  
  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    
    if @search.nil?
      @search = Course.search(params[:search])
    end

    @courses = @search.paginate(:page => params[:page]) unless @search.nil?
    redirect_to(courses_path(:search => params[:search]))
  end

  def export
    if @search.nil?
      @search = Course.search(params[:search])
      @courses = nil
    else
      @search.meta_sort = "course_number.asc" if @search.meta_sort.nil?
      @courses = @search.all
    end
    
    send_data @courses.to_xls_data, :filename => 'courses.xls'
  end
end

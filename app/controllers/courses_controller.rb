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
      @search = Course.search(params[:search])
      @courses = nil
    else
      @courses = @search.paginate(:page => params[:page]) unless @search.nil?
    end
  end
  
  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end
  
  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end
  
  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end
  
  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    
    respond_to do |format|
      if @course.save
        flash[:notice] = 'Course was successfully created.'
        format.html { redirect_to(@course) }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = 'Course was successfully updated.'
      @courses = @search.paginate(:page => params[:page]) unless @search.nil?
    end
  end
  
  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    
    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
end

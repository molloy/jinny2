class CourseTakensController < ApplicationController
  before_filter :require_user, :load_search_params

  respond_to :xls, :only => :export

  def load_search_params
    @search = search_by_meta :course_taken
  end

  # GET /course_takens
  # GET /course_takens.xml
  def index
    if @search.nil?
      @search = CourseTaken.search(params[:search])
      @course_takens = nil
    else
      # @search.meta_sort = "surname.asc" if @search.meta_sort.nil?
      @course_takens = @search.paginate(:page => params[:page])
    end
  end

  # GET /course_takens/1
  # GET /course_takens/1.xml
  def show
    @course_taken = CourseTaken.find(params[:id])
  end

  # GET /course_takens/new
  # GET /course_takens/new.xml
  def new
    @course_taken = CourseTaken.new
  end

  # GET /course_takens/1/edit
  def edit
    @course_taken = CourseTaken.find(params[:id])
  end

  # POST /course_takens
  # POST /course_takens.xml
  def create
    @course_taken = CourseTaken.new(params[:course_taken])

    if @search.nil?
      @search = CourseTaken.search(params[:search])
    end

    if @course_taken.save
      flash[:notice] = 'CourseTaken was created updated.'
      @course_takens = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(course_takens_path(:search => params[:search]))
    end
  end

  # PUT /course_takens/1
  # PUT /course_takens/1.xml
  def update
    @course_taken = CourseTaken.find(params[:id])

    if @search.nil?
      @search = CourseTaken.search(params[:search])
    end

    if @course_taken.update_attributes(params[:course_taken])
      flash[:notice] = 'CourseTaken was successfully updated.'
      @course_takens = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(course_takens_path(:search => params[:search]))
    end
  end

  # DELETE /course_takens/1
  # DELETE /course_takens/1.xml
  def destroy
    @course_taken = CourseTaken.find(params[:id])
    @course_taken.destroy

    if @search.nil?
      @search = CourseTaken.search(params[:search])
    end

    @course_takens = @search.paginate(:page => params[:page]) unless @search.nil?
    redirect_to(course_takens_path(:search => params[:search]))
  end

  def export
    if @search.nil?
      @course_takens = CourseTaken.search(params[:search])
      @course_takens = nil
    else
      # @search.meta_sort = "surname.asc" if @search.meta_sort.nil?
      @course_takens = @search.all
    end
    
    send_data @course_takens.to_xls_data(:columns => [{:person => [:given_name, :surname, :ssn, {:degree_program => [:title]}]}, {:course_offering => [{:course => [:course_number, :name]}, :year, {:term_type => [:name]}]}, {:course_taken_status => [:name]}, {:grade_type => [:name]}]), :filename => 'transcritps.xls'
  end
end

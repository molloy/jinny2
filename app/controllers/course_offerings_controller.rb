class CourseOfferingsController < ApplicationController
  before_filter :load_search_params, :require_user

  autocomplete :course_number_and_name, { :course => [:course_number, :name] }, :display_value => :course_number_and_name, :full => true, :limit => 1000
  autocomplete :person_fullname, { :person => [:given_name, :surname] }, :display_value => :full_name, :where_filter => ('person_type_id = ' + PersonType.faculty.id.to_s), :full => true

  def load_search_params
    @search = search_by_meta :course_offering
  end
  
  # GET /course_offerings
  # GET /course_offerings.xml
  def index
    if @search.nil?
      @search = CourseOffering.search(params[:search])
      @course_offerings = nil
    else
      @search.meta_sort = "year.asc" if @search.meta_sort.nil?
      @course_offerings = @search.paginate(:page => params[:page])
    end
  end

  # GET /course_offerings/1
  # GET /course_offerings/1.xml
  def show
    @course_offering = CourseOffering.find(params[:id])
  end

  # GET /course_offerings/new
  # GET /course_offerings/new.xml
  def new
    @course_offering = CourseOffering.new
  end

  # GET /course_offerings/1/edit
  def edit
    @course_offering = CourseOffering.find(params[:id])
  end

  # POST /course_offerings
  # POST /course_offerings.xml
  def create
    @course_offering = CourseOffering.new(params[:course_offering])

    if @search.nil?
      @search = CourseOffering.search(params[:search])
    end

    if @course_offering.save
      flash[:notice] = 'Course Offering was successfully created.'
      @course_offerings = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(course_offerings_path(:search => params[:search]))
    end
  end

  # PUT /course_offerings/1
  # PUT /course_offerings/1.xml
  def update
    @course_offering = CourseOffering.find(params[:id])

    # logger.debug @course_offering.syllabus
    # unless params[:syllabus].blank?
    #   @course_offering.uploaded_file = params[:syllabus]
    # end

    # respond_to do |format|
    #   if @course_offering.update_attributes(params[:course_offering])
    #     flash[:notice] = 'CourseOffering was successfully updated.'
    #     format.html { redirect_to(@course_offering) }
    #     format.xml  { head :ok }
    #   else
    #     format.html { render :action => "edit" }
    #     format.xml  { render :xml => @course_offering.errors, :status => :unprocessable_entity }
    #   end
    # end

    if @course_offering.update_attributes(params[:course_offering])
      flash[:notice] = 'Course Offering was successfully updated.'
      @course_offerings = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(course_offerings_path(:search => params[:search]))
    end
  end

  # DELETE /course_offerings/1
  # DELETE /course_offerings/1.xml
  def destroy
    @course_offering = CourseOffering.find(params[:id])
    @course_offering.destroy

    if @search.nil?
      @search = CourseOffering.search(params[:search])
    end

    @course_offerings = @search.paginate(:page => params[:page]) unless @search.nil?
    redirect_to(course_offerings_path(:search => params[:search]))
  end
end

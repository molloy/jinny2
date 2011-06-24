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
      @course_offerings = @search.all unless @search.nil?
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
    # respond_to do |format|
    #   if @course_offering.save
    #     flash[:notice] = 'The Course Offering was successfully created.'
    #   else
    #     format.js { render :action => "new" }
    #   end
    # end

    if @course_offering.save
      flash[:notice] = 'Course Offering was successfully created.'
      render :action => 'index'
    else
      render :action => 'new'
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
    #   render :action => 'index'
    # else
    #   render :action => 'edit'
    end
  end

  # DELETE /course_offerings/1
  # DELETE /course_offerings/1.xml
  def destroy
    @course_offering = CourseOffering.find(params[:id])
    @course_offering.destroy

    render 'index.js.erb'
  end
  
  # def search
  #   if @search_condition_params && (defined? @search_condition_params['show_all']) && (@search_condition_params['show_all'])
  #     @course_offerings = CourseOffering.all
  #   else
  #     @search_condition_params = search_condition_parameters
  #     search_conditions = @search_condition_params[0]
  #     unless search_conditions.blank?
  #       @course_offerings = CourseOffering.where(@search_condition_params).all
  #     end
  #   end
    
    # if params[:show_all]
    #   @course_offerings = CourseOffering.all
    # else
    #   @search_condition_params = search_condition_parameters
    #   search_conditions = @search_condition_params[0]
    #   unless search_conditions.blank?
    #     @course_offerings = CourseOffering.where(@search_condition_params).all
    #   end
    # end
  # end

  # def syllabus_data
  #   @course_offerings = CourseOffering.find(params[:id])
  #   if @course_offerings.syllabus
  #     send_data(@course_offerings.syllabus, :file_name => @course_offerings.syllabus_file_name, :content_type => @course_offerings.syllabus_content_type, :disposition => 'inline')
  #   else
  #     send_data(' ', :content_type => 'text/html')
  #   end
  # end

  def filter_by_year
    @course_offerings_by_year = CourseOffering.where(:year => params['year'])
    
    render :partial => "course_offerings_by_year"
  end
  
end

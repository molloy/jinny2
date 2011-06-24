class PeopleController < ApplicationController
  before_filter :require_user, :load_search_params
  
  autocomplete :degree_program_title, { :degree_program => [:title] }, :display_value => :title, :full => true
  autocomplete :department_name, { :department => [:name] }, :display_value => :name, :full => true

  def load_search_params
    @search = search_by_meta :person
    if params[:person_type].nil?
      params[:person_type] = PersonType.student.id
    end
  end

  # GET /people
  # GET /people.xml
  def index
    if @search.nil?
      @search = Person.search(params[:search])
      @people = nil
    else
      @people = @search.all unless @search.nil?
    end
    
    # if is_student
    #   @person = current_person
    #   redirect_to(@person)
    # end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new
    @person.addresses_attributes = [ { :address_type => AddressType.home }, { :address_type => AddressType.mailing } ]
    @person.phones_attributes = [ { :phone_type => PhoneType.mobile }, { :phone_type => PhoneType.home }, { :phone_type => PhoneType.work } ]
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])
    
    if @search.nil?
      @search = Person.search(params[:search])
    end

    if @person.update_attributes(params[:person])
      flash[:notice] = 'Course was successfully updated.'
      @people = @search.all unless @search.nil?
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
  
  # def search
  #   if params[:show_all]
  #     if (is_student)
  #       @people = [current_person]
  #     else
  #       @people = Person.where("person_type_id = ?", params[:person_type]).all
  #     end
  #   else
  #     search_condition_params = search_condition_parameters
  #     search_conditions = search_condition_params[0]
  #     unless search_conditions.blank?
  #       @people = Person.where(search_condition_params).all
  #     end
  #   end
  # end
  
  def filter_by_year
    @course_offerings_by_year = CourseOffering.where(:year => params['year'])
    
    render :partial => "course_offerings_by_year"
  end
  
  def picture_image
    @person = Person.find(params[:id])
    @picture = @person.picture
    if @picture
      send_data(@picture, :type => @person.picture_content_type, :file_name => @person.picture_file_name, :disposition => 'inline')
    else
      send_data(' ', :type => 'text/html', :disposition => 'inline')
    end
  end

  def resume_cv_data
    @person = Person.find(params[:id])
    @resume_cv = @person.resume_cv
    if @resume_cv
      send_data(@resume_cv, :type => @person.resume_cv_content_type, :file_name => @person.resume_cv_file_name, :disposition => 'inline')
    else
      send_data(' ', :type => 'text/html', :disposition => 'inline')
    end
  end

  # GET /people/register
  # GET /people/register.xml
  def register
    @person.addresses_attributes = [ { :address_type_id => address_type_home.id }, { :address_type_id => address_type_mailing.id } ]
    @person.phones_attributes = [ { :phone_type_id => phone_type_mobile.id }, { :phone_type_id => phone_type_home.id }, { :phone_type_id => @phone_type_work.id } ]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # POST /people
  # POST /people.xml
  def register_new
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "register" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

end

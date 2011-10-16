class PeopleController < ApplicationController
  before_filter :require_user, :load_search_params
  
  autocomplete :degree_program_title, { :degree_program => [:title] }, :display_value => :title, :full => true
  autocomplete :department_name, { :department => [:name] }, :display_value => :name, :full => true

  helper_method :is_student_screen, :is_faculty_screen, :is_administrator_screen

  respond_to :xls, :only => :export
  
  def load_search_params
    @search = search_by_meta :person
  end

  # GET /people
  # GET /people.xml
  def index
    if @search.nil?
      @search = Person.search(params[:search])
      @people = nil
    else
      @search.meta_sort = "surname.asc" if @search.meta_sort.nil?
      @people = @search.paginate(:page => params[:page])
    end    
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
    @person = Person.includes(:course_takens => :course_offering).order('course_offerings.year, course_offerings.term_type_id').find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    if @search.nil?
      @search = Person.search(params[:search])
    end

    if @person.save
      flash[:notice] = 'Person was successfully created.'
      @people = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(people_path(:person_type => params[:person_type], :search => params[:search]))
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
      flash[:notice] = 'Person was successfully updated.'
      @people = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(people_path(:person_type => params[:person_type], :search => params[:search]))
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    if @search.nil?
      @search = Person.search(params[:search])
    end

    @people = @search.paginate(:page => params[:page]) unless @search.nil?
    redirect_to(people_path(:person_type => params[:person_type], :search => params[:search]))
  end
  
  def export
    if @search.nil?
      @search = Person.search(params[:search])
      @people = nil
    else
      @search.meta_sort = "surname.asc" if @search.meta_sort.nil?
      @people = @search.all
    end
    
    send_data @people.to_xls_data, :filename => 'people.xls'
  end
  
private
  def is_student_screen
    params[:person_type] == PersonType.student.id.to_s
  end

  def is_faculty_screen
    params[:person_type] == PersonType.faculty.id.to_s
  end

  def is_administrator_screen
    params[:person_type] == PersonType.administrator.id.to_s
  end
end

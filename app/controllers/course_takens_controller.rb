class CourseTakensController < ApplicationController
  before_filter :require_user

  # GET /course_takens
  # GET /course_takens.xml
  def index
    @course_takens = CourseTaken.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @course_takens }
    end
  end

  # GET /course_takens/1
  # GET /course_takens/1.xml
  def show
    @course_taken = CourseTaken.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course_taken }
    end
  end

  # GET /course_takens/new
  # GET /course_takens/new.xml
  def new
    @course_taken = CourseTaken.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course_taken }
    end
  end

  # GET /course_takens/1/edit
  def edit
    @course_taken = CourseTaken.find(params[:id])
  end

  # POST /course_takens
  # POST /course_takens.xml
  def create
    @course_taken = CourseTaken.new(params[:course_taken])

    respond_to do |format|
      if @course_taken.save
        flash[:notice] = 'CourseTaken was successfully created.'
        format.html { redirect_to(@course_taken) }
        format.xml  { render :xml => @course_taken, :status => :created, :location => @course_taken }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course_taken.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /course_takens/1
  # PUT /course_takens/1.xml
  def update
    @course_taken = CourseTaken.find(params[:id])

    respond_to do |format|
      if @course_taken.update_attributes(params[:course_taken])
        flash[:notice] = 'CourseTaken was successfully updated.'
        format.html { redirect_to(@course_taken) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course_taken.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /course_takens/1
  # DELETE /course_takens/1.xml
  def destroy
    @course_taken = CourseTaken.find(params[:id])
    @course_taken.destroy

    respond_to do |format|
      format.html { redirect_to(course_takens_url) }
      format.xml  { head :ok }
    end
  end
end

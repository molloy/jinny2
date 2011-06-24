class CourseTakenStatusesController < ApplicationController
  before_filter :require_user

  # GET /course_taken_statuses
  # GET /course_taken_statuses.xml
  def index
    @course_taken_statuses = CourseTakenStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @course_taken_statuses }
    end
  end

  # GET /course_taken_statuses/1
  # GET /course_taken_statuses/1.xml
  def show
    @course_taken_status = CourseTakenStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course_taken_status }
    end
  end

  # GET /course_taken_statuses/new
  # GET /course_taken_statuses/new.xml
  def new
    @course_taken_status = CourseTakenStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course_taken_status }
    end
  end

  # GET /course_taken_statuses/1/edit
  def edit
    @course_taken_status = CourseTakenStatus.find(params[:id])
  end

  # POST /course_taken_statuses
  # POST /course_taken_statuses.xml
  def create
    @course_taken_status = CourseTakenStatus.new(params[:course_taken_status])

    respond_to do |format|
      if @course_taken_status.save
        flash[:notice] = 'CourseTakenStatus was successfully created.'
        format.html { redirect_to(@course_taken_status) }
        format.xml  { render :xml => @course_taken_status, :status => :created, :location => @course_taken_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course_taken_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /course_taken_statuses/1
  # PUT /course_taken_statuses/1.xml
  def update
    @course_taken_status = CourseTakenStatus.find(params[:id])

    respond_to do |format|
      if @course_taken_status.update_attributes(params[:course_taken_status])
        flash[:notice] = 'CourseTakenStatus was successfully updated.'
        format.html { redirect_to(@course_taken_status) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course_taken_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /course_taken_statuses/1
  # DELETE /course_taken_statuses/1.xml
  def destroy
    @course_taken_status = CourseTakenStatus.find(params[:id])
    @course_taken_status.destroy

    respond_to do |format|
      format.html { redirect_to(course_taken_statuses_url) }
      format.xml  { head :ok }
    end
  end
end

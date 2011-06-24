class GradeTypesController < ApplicationController
  before_filter :require_user

  # GET /grade_types
  # GET /grade_types.xml
  def index
    @grade_types = GradeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grade_types }
    end
  end

  # GET /grade_types/1
  # GET /grade_types/1.xml
  def show
    @grade_type = GradeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grade_type }
    end
  end

  # GET /grade_types/new
  # GET /grade_types/new.xml
  def new
    @grade_type = GradeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grade_type }
    end
  end

  # GET /grade_types/1/edit
  def edit
    @grade_type = GradeType.find(params[:id])
  end

  # POST /grade_types
  # POST /grade_types.xml
  def create
    @grade_type = GradeType.new(params[:grade_type])

    respond_to do |format|
      if @grade_type.save
        flash[:notice] = 'GradeType was successfully created.'
        format.html { redirect_to(@grade_type) }
        format.xml  { render :xml => @grade_type, :status => :created, :location => @grade_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grade_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grade_types/1
  # PUT /grade_types/1.xml
  def update
    @grade_type = GradeType.find(params[:id])

    respond_to do |format|
      if @grade_type.update_attributes(params[:grade_type])
        flash[:notice] = 'GradeType was successfully updated.'
        format.html { redirect_to(@grade_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grade_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_types/1
  # DELETE /grade_types/1.xml
  def destroy
    @grade_type = GradeType.find(params[:id])
    @grade_type.destroy

    respond_to do |format|
      format.html { redirect_to(grade_types_url) }
      format.xml  { head :ok }
    end
  end
end

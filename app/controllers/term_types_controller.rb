class TermTypesController < ApplicationController
  before_filter :require_user

  # GET /term_types
  # GET /term_types.xml
  def index
    @term_types = TermType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @term_types }
    end
  end

  # GET /term_types/1
  # GET /term_types/1.xml
  def show
    @term_type = TermType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @term_type }
    end
  end

  # GET /term_types/new
  # GET /term_types/new.xml
  def new
    @term_type = TermType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @term_type }
    end
  end

  # GET /term_types/1/edit
  def edit
    @term_type = TermType.find(params[:id])
  end

  # POST /term_types
  # POST /term_types.xml
  def create
    @term_type = TermType.new(params[:term_type])

    respond_to do |format|
      if @term_type.save
        flash[:notice] = 'TermType was successfully created.'
        format.html { redirect_to(@term_type) }
        format.xml  { render :xml => @term_type, :status => :created, :location => @term_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @term_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /term_types/1
  # PUT /term_types/1.xml
  def update
    @term_type = TermType.find(params[:id])

    respond_to do |format|
      if @term_type.update_attributes(params[:term_type])
        flash[:notice] = 'TermType was successfully updated.'
        format.html { redirect_to(@term_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @term_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /term_types/1
  # DELETE /term_types/1.xml
  def destroy
    @term_type = TermType.find(params[:id])
    @term_type.destroy

    respond_to do |format|
      format.html { redirect_to(term_types_url) }
      format.xml  { head :ok }
    end
  end
end

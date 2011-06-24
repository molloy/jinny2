class InvoicesController < ApplicationController
  before_filter :require_user

  # GET /invoices
  # GET /invoices.xml
  def index
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
    @bill_to_addresses = Address.where(:person_id => @invoice.bill_to).all
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        flash[:notice] = 'Invoice was successfully created.'
        format.html { redirect_to(@invoice) }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        flash[:notice] = 'Invoice was successfully updated.'
        format.html { redirect_to(@invoice) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url) }
      format.xml  { head :ok }
    end
  end

  def search
    logger.debug params
    if params[:show_all]
      @invoices = Invoice.all
    else
      search_condition_params = search_condition_parameters_with_bill_to
      search_conditions = search_condition_params[0]
      unless search_conditions.blank?
        @invoices = Invoice.find(search_condition_params).all
      end
    end
    
    render :partial => "search_result"
  end
  
  def search_bill_to
    search_condition_params = search_person_parameters(params["bill_to_name"])
    search_conditions = search_condition_params[0]
    unless search_conditions.blank?
      @people = Person.find(search_condition_params).all
    end

    render :partial => "search_bill_to"
  end
  
  def search_bill_to_address
    logger.debug "you got called"
    logger.debug params[:invoice][:bill_to]
    @bill_to_addresses = Address.find(:person_id => params[:invoice][:bill_to]).all
    logger.debug @bill_to_addresses.length
    
    render :partial => "bill_to_address_results", :locals => { :bill_to_addresses => @bill_to_addresses }
  end
  
  def search_condition_parameters_with_bill_to
    search_condition_params = search_condition_parameters
    search_conditions = search_condition_params[0]
    if (params["bill_to_selected"])
      unless search_conditions.blank?
        search_conditions << " and "
      end
      search_conditions << "(people.given_name = ? or people.surname = ?)"
      search_condition_params[0] = search_conditions
      search_condition_params[search_condition_params.length] = params["bill_to_search"]
      search_condition_params[search_condition_params.length] = params["bill_to_search"]
    end
    return search_condition_params
  end
end

class UsersController < ApplicationController
  before_filter :require_user, :load_search_params

  def load_search_params
    @search = search_by_meta :user
  end

  # GET /users
  # GET /users.xml
  def index
    if @search.nil?
      @search = User.search(params[:search])
      @users = nil
    else
      @search.meta_sort = "email.asc" if @search.meta_sort.nil?
      @users = @search.all
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = 'User was successfully created.'
      render :action => 'index'
    else
      render :action => 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end

    @search = User.search(params[:search])
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end

    @search = User.search(params[:search])
  end
end

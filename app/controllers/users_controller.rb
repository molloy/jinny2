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
      @users = @search.paginate(:page => params[:page])
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

    if @search.nil?
      @search = User.search(params[:search])
    end

    if @user.save
      flash[:notice] = 'User was successfully created.'
      @users = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(users_path(:search => params[:search]))
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      @users = @search.paginate(:page => params[:page]) unless @search.nil?
      redirect_to(users_path(:search => params[:search]))
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @search.nil?
      @search = User.search(params[:search])
    end

    @users = @search.paginate(:page => params[:page]) unless @search.nil?
    redirect_to(users_path(:search => params[:search]))
  end
end

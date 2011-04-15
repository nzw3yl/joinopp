class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  layout "welcome", :except => [:show, :index]  


  def new
    @title = "Welcome"
    @user = User.new
    render 'pages/welcome'
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name 
    render :layout => "application"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to JoinOpp!"
      redirect_to @user
    else
      @title = "Welcome"
      render 'pages/welcome'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
       flash[:success] = "Profile updated."
       redirect_to @user
    else
       @title = "Edit user"
       render 'edit'
    end
  end

  def index
    @title = "All Users"
    @users = User.order("name").page(params[:page]).per(20)
    render :layout => "application"
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

 
end

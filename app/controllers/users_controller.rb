class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  layout "welcome", :except => [:edit, :show, :index]  


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
    @has_invite = @user.new_invitee?
    @user.errors.add(:welcome_code, "error! Please verify your welcome code.") unless @has_invite
    if  @has_invite && @user.save   
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
    render :layout => "application"
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

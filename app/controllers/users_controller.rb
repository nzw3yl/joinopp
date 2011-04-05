class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show]
  before_filter :correct_user, :only => [:edit, :update]
  layout "welcome", :except => [:show]  


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


  private

	def authenticate 
	  deny_access unless signed_in?
        end

        def correct_user
	  @user = User.find(params[:id])
  	  redirect_to(root_path) unless current_user?(@user)
        end
end

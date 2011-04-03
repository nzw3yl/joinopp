class UsersController < ApplicationController
  
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

end

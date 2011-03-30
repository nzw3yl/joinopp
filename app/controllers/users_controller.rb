class UsersController < ApplicationController
  
  layout "welcome", :except => [:show]  


  def new
    @title = "Welcome"
    render 'pages/welcome'
  end

  def show
    @user = User.find(params[:id])
    render :layout => "application"
  end

end

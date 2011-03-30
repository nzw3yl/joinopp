class UsersController < ApplicationController
  
  layout "welcome", :except => [:show]  


  def new
    @title = "Welcome"
    render 'pages/welcome'
  end

  def show
    @user = User.find(params[:id])
    @title = @user.first_name + " " + @user.last_name
    render :layout => "application"
  end

end

class SessionsController < ApplicationController
  layout 'welcome'
 
  def new
     @title = "Welcome"
     render 'pages/welcome'
  end

  def create
     user = User.authenticate(params[:session][:email], params[:session][:password])

     if user.nil?
        flash[:error] = "Invalid email/password combination"
        @title = "Welcome"
	render :new
     else
        sign_in user
        redirect_back_or user
     end
  end

  def destroy 
     sign_out
     redirect_to root_path
  end

end

class UsersController < ApplicationController

  layout "welcome", :except => [:index]  

  def new
    @title = "Welcome"
    render 'pages/welcome'
  end

end

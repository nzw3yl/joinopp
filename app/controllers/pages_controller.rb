class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def privacy
    @title = "Privacy"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def welcome
    @title = "Welcome"
    render :layout => 'welcome'
  end

end

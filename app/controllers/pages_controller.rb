class PagesController < ApplicationController

  layout :content_layout

  def home
    if !signed_in? 
	redirect_to :action => :welcome and return
    end
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
    if signed_in? 
	redirect_to :action => :home and return
    end
    @title = "Welcome"
    @user = User.new
    #render :layout => 'welcome'
  end

  private
 
    def content_layout
      signed_in? ? "application" : "welcome"
    end

end

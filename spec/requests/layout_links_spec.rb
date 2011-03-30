require 'spec_helper'

describe "LayoutLinks" do

 
    
    it "should have a Welcome page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Welcome")
    end

    it "should have a Welcome page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Welcome")
    end

     it "should have a Home page at '/home'" do
      get '/home'
      response.should have_selector('title', :content => "Home")
    end

     it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

     it "should have a Privacy page at '/privacy'" do
      get '/privacy'
      response.should have_selector('title', :content => "Privacy")
    end

     it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end

    it "should have a Help page at '/help'" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end

    it "should have the right links on the Welcome layout" do
      get root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Privacy"
      response.should have_selector('title', :content => "Privacy")
    end

    it "should have the right links on the Application layout" do
      get home_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Privacy"
      response.should have_selector('title', :content => "Privacy")
    end


end

require 'spec_helper'

describe "Undertakings" do
   
  before (:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :session_email,	:with => user.email
    fill_in :session_password,  :with => user.password
    click_button
  end

  describe "creation" do
    
    describe "failure" do
      
      it "should not create a new undertaking" do
        lambda do
          visit new_undertaking_path
          fill_in :undertaking_title,		:with => ""
          fill_in :undertaking_description,	:with => ""
          click_button
	  response.should render_template('undertakings/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Undertaking, :count)
      end
    end

    describe "success" do
      it "should create a new undertaking" do
        lambda do
          visit new_undertaking_path
          fill_in :undertaking_title,		:with => "Kill Bill"
          fill_in :undertaking_description,	:with => "5 finger exploding heart"
          click_button
	  response.should render_template('undertakings/show')
          response.should have_selector("div.flash.success", :content => "Undertaking")
          response.should have_selector("div#undertaking_title", :content => "Kill Bill")
        end.should change(Undertaking, :count).by(1)
      end

    end
  end
   

end

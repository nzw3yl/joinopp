require 'spec_helper'

describe "Users" do

  describe "signup" do

     describe "failure" do

    	it "should not make a new user" do
              lambda do
		visit root_path
		fill_in :user_name,		:with => ""
		fill_in :user_email,		:with => ""
		fill_in :user_password,		:with => ""
		fill_in :user_password_confirmation,	:with => ""
		fill_in :user_welcome_code,	:with => ""
		click_button :user_submit
		response.should render_template('pages/welcome')
		response.should have_selector("div#error_explanation")
              end.should_not change(User, :count)
    	end  

     end

     describe "success" do

    	it "should make a new user" do
              
              lambda do
                invitation = Factory(:invitation, :email => "user@example.com", :access_code => "welcome")
		visit root_path
		fill_in :user_name,		:with => "Example User"
		fill_in :user_email,		:with => "user@example.com"
		fill_in :user_password,	:with => "foobar"
		fill_in :user_password_confirmation,	:with => "foobar"
		fill_in :user_welcome_code,	:with => "welcome"
		click_button :user_submit
		response.should have_selector("div.flash.success", :content => "Welcome")
                response.should render_template('users/show')
              end.should change(User, :count).by(1)
    	end  

     end
  end

  describe "sign in/out" do

        before(:each) do
          @invitation = Factory(:invitation)
        end

	describe "failure" do
	  it "should not sign a user in" do
                visit root_path
		fill_in :session_email,		:with => ""
		fill_in :session_password,	:with => ""
                click_button :session_submit
		response.should have_selector("div.flash.error", :content => "Invalid")
          end
        end

        describe "success" do
  	  it "should sign a user in and out" do
		user = Factory(:user)
		visit root_path
		fill_in :session_email,		:with => user.email
		fill_in :session_password,	:with => user.password
		click_button :session_submit
		controller.should be_signed_in
		click_link "Sign out"
		controller.should_not be_signed_in
	  end
        end

  end
end

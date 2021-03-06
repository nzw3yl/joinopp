require 'spec_helper'

describe SessionsController do

  render_views

  before(:each) do
    @base_title = "JoinOpp"
  end

  describe "GET 'new'" do
   
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => @base_title + " | Welcome")
    end
  end

  describe "POST 'create'" do
    
     describe "failure" do

	    before(:each) do
	       @attr = { :email => "email@example.com", :password => "invalid" }
	    end
	    # TODO: Fix this so it knows it ends up at the Welcome page 
	    it "should redirect to the welcome page" do
	       post :create, :session => @attr
	       response.should render_template(:new)
	    end

	    it "should have flash.now message" do
	       post :create, :session => @attr
	       flash.now[:error].should =~ /invalid/i
	    end
      end

     describe "success" do
	
	before(:each) do
          @invitation = Factory(:invitation)
    	  @user = Factory(:user)
          @attr = { :email => @user.email, :password => @user.password }
  	end

        it "should sign the user in" do
	  post :create, :session => @attr
          controller.current_user.should == @user
          controller.should be_signed_in
        end

        it "should redirect to the user show page" do
	  post :create, :session => @attr
	  response.should redirect_to(user_path(@user))
        end
	
     end

  end

  describe "DELETE 'destroy'" do

	it "should sign a user out" do
           @invitation = Factory(:invitation)
	   test_sign_in(Factory(:user))
           delete :destroy
           controller.should_not be_signed_in
           response.should redirect_to(root_path)
        end

  end 

end

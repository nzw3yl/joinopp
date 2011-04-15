require 'spec_helper'

describe UndertakingsController do
  render_views

  describe "access control" do
   
   it "should deny access to 'create'" do
    post :create
    response.should redirect_to(signin_path)
   end

  end

  describe "GET 'new'" do
   before (:each) do
      @user = test_sign_in(Factory(:user))
    end

    it "should be successful" do
      get :new
      response.should be_success
    end

  end

  describe "POST 'create'" do

    before (:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "success" do

      before (:each) do
        @attr = {:title => "Kill Bill", :description => "5 finger exploding heart", :access_code => "welcome"}
      end

      it "should create an undertaking" do
	lambda do
	  post :create, :undertaking => @attr
        end.should change(Undertaking, :count).by(1)
      end      
    end

    describe "failure" do

      before (:each) do
        @attr = {:title => "Kill", :description => "5", :access_code => ""}
      end

      it "should not create an undertaking" do
	lambda do
	  post :create, :undertaking => @attr
        end.should_not change(Undertaking, :count)
      end      
    end
  end

end

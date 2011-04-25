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
          @user.undertakings.create!(@attr)
	  #post :create, :undertaking => @attr
        end.should change(Undertaking, :count).by(1)
      end      
    end

    describe "failure" do

      before (:each) do
        @attr = {:title => "Kill", :description => "5", :access_code => ""}
      end

      it "should not create an undertaking" do
	lambda do
	  @user.undertakings.create(@attr)
	  #post :create, :undertaking => @attr
        end.should_not change(Undertaking, :count)
      end      
    end
  end

  describe "GET 'admin_index'" 

   describe "for non-signed in users" do
      it "should deny access" do
        get :admin_index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user, :admin => true))
        first = Factory(:undertaking, :title => "Kill Bill", :description => "5 finger exploding heart", :access_code => "welcome 001")
	second = Factory(:undertaking, :title => "Kill Bill", :description => "5 finger exploding heart", :access_code => "welcome 002")
	third  = Factory(:undertaking, :title => "Kill Bill", :description => "5 finger exploding heart", :access_code => "welcome 003")

    	@undertakings = [first, second, third]
        30.times do
	  @undertakings << Factory(:undertaking, :access_code => Factory.next(:access_code))
        end
      end

      it "should have the right title" do
        get :admin_index
        response.should have_selector(:title, :content => "Admin Index")
      end

      it "should have an element for each undertaking" do
   	get :admin_index
	@undertakings[0..2].each do |undertaking|
	  response.should have_selector("li", :content => undertaking.title)
	end
      end

      it "should paginate undertakings" do
	get :admin_index
	response.should have_selector("nav.pagination")
        response.should have_selector("a", :href => "/admin_undertaking?page=2", :content => "2")
	response.should have_selector("a", :href => "/admin_undertaking?page=2", :content => "Next")
	
      end

    end

     describe "DELETE 'destroy'" do
    
    before(:each) do
      @undertaking = Factory(:undertaking)
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
         delete :destroy, :id => @undertaking
         response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
         test_sign_in(@user)
         delete :destroy, :id => @undertaking
         response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do
      
      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", 
                                :welcome_code => "welcome_admin",
                                :admin => true)
        test_sign_in(admin)
        @undertaking = Factory(:undertaking)
      end

      it "should destroy the undertaking" do
	lambda do
	  delete :destroy, :id => @undertaking
        end.should change(Undertaking, :count).by(-1)
      end

      it "should redirect to the undertakings page" do
	  delete :destroy, :id => @undertaking
	  response.should redirect_to(undertakings_path)
      end
    end
  end

    describe "PUT 'update'" do
    before(:each) do
	@user = Factory(:user)
	test_sign_in(@user)
        @undertaking = Factory(:undertaking)
    end

    describe "failure" do
      before(:each) do
	@attr = {:title => "", :description => "", :success_if => "" }
      end

      it "should render the 'edit' page"  do
        put :update, :id => @undertaking, :undertaking => @attr
	response.should render_template('edit')
      end

      it "should have the right title page"  do
        put :update, :id => @undertaking, :undertaking => @attr
	response.should have_selector("title", :content => "Edit Undertaking")
      end
    end

    describe "success" do
      before(:each) do
	@attr = {:title => "Kill Bill2", :description => "New Description" }
      end

      it "should change the undertaking's attributes"  do
        put :update, :id => @undertaking, :undertaking => @attr
	@undertaking.reload
	@undertaking.title.should == @attr[:title]
        @undertaking.description.should == @attr[:description]
      end

      it "should redirect to the undertaking show page"  do
        put :update, :id => @undertaking, :undertaking => @attr
	response.should redirect_to(undertaking_path(@undertaking))
      end

      it "should have a flash message"  do
        put :update, :id => @undertaking, :undertaking => @attr
	flash[:success].should =~ /updated/
      end      
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
      @undertaking = Factory(:undertaking)
    end

    describe "for non-signed in users" do
     
      it "should deny access to 'edit'" do
        get :edit, :id => @undertaking
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @undertaking, :undertaking => {}
        response.should redirect_to(signin_path)
      end

    end


  end

end

require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @base_title = "JoinOpp"
  end
 
  describe "GET 'index'" do

    describe "for non-signed in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
      
      before(:each) do
        @invitation = Factory(:invitation)
	secondi = Factory(:invitation, :access_code => "Bob", :email => "another@example.com")
	thirdi  = Factory(:invitation, :access_code => "Ben", :email => "another@example.net")

        @user = test_sign_in(Factory(:user))
	second = Factory(:user, :name => "Bob", :email => "another@example.com",:welcome_code => "Bob")
	third  = Factory(:user, :name => "Ben", :email => "another@example.net", :welcome_code => "Ben")
 
        @invitations = [@invitation, secondi, thirdi]
    	@users = [@user, second, third]
        20.times do
          @invitations << Factory(:invitation, :email => Factory.next(:i_email), :access_code => Factory.next(:i_access_code))
	  @users << Factory(:user, :email => Factory.next(:email), :welcome_code => Factory.next(:welcome_code))
        end
      end

      it "should have the right title" do
        get :index
        response.should have_selector(:title, :content => "All Users")
      end

      it "should have an element for each user" do
   	get :index
	@users[0..2].each do |user|
	  response.should have_selector("li", :content => user.name)
	end
      end

      it "should paginate users" do
	get :index
	response.should have_selector("nav.pagination")
        response.should have_selector("a", :href => "/users?page=2", :content => "2")
	response.should have_selector("a", :href => "/users?page=2", :content => "Next")
	
      end

    end


  end

  describe "GET 'show'" do

    before(:each) do
      @invitation = Factory(:invitation)
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should have the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => @base_title + " | Welcome")
    end
  end

  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { 	:name => "", 
			:welcome_code => "", 
			:email => "", 
			:password => "", 
			:password_confirmation => "" 
		}
      end

      it "should not create a user" do
	lambda do
    	  post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Welcome")
      end

      it "should render the 'welcome' page" do
	post :create, :user => @attr
	response.should render_template('welcome')
      end

      describe "invalid invitation" do
        before(:each) do
		@attr = { :name => "New User", :email => "user@zzzzzz.com" , :welcome_code => "lkasdhdfhafh", 
			  :password => "foobar", :password_confirmation => "foobar" }
               
	end
        it "should reject a mismatched email address" do
            lambda do
              @invitation = Factory(:invitation, :email => "user@example.net", :access_code => "welcome")
    	      post :create, :user => @attr
            end.should_not change(User, :count)
        end

        it "should reject an invalid welcome code" do
            lambda do
              @invitation = Factory(:invitation, :email => "user@example.com", :access_code => "keepout")
    	      post :create, :user => @attr
            end.should_not change(User, :count)
        end

      end

    end

     describe "success" do
       
	before(:each) do
		@attr = { :name => "New User", :email => "user@example.com" , :welcome_code => "welcome", 
			  :password => "foobar", :password_confirmation => "foobar" }
                @invitation = Factory(:invitation, :email => "user@example.com", :access_code => "welcome")
	end

	it "should create a user" do
		lambda do
		   post :create, :user => @attr
		end.should change(User, :count).by(1)
	end

 	it "should redirect to the user show page" do
		post :create, :user => @attr
		response.should redirect_to(user_path(assigns(:user)))
	end

  	it "should have a welcome message" do
		post :create, :user => @attr
		flash[:success].should =~ /welcome/i
	end

        it "should sign the user in" do
       		post :create, :user => @attr
 		controller.should be_signed_in
        end
    end

  end

  describe "Get 'edit'" do
	
    before(:each) do
        @invitation = Factory(:invitation)
	@user = Factory(:user)
	test_sign_in(@user)
    end

    it "should be successful" do
	get :edit, :id => @user
  	response.should be_success
    end

    it "should have the right title" do
	get :edit, :id => @user
	response.should have_selector("title", :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
	get :edit, :id => @user
	gravatar_url = "http://gravatar.com/emails"
	response.should have_selector("a", :href => gravatar_url, :content => "change")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
        @invitation = Factory(:invitation)
	@user = Factory(:user)
	test_sign_in(@user)
    end

    describe "failure" do
      before(:each) do
	@attr = {:email => "", :name => "", :password => "", :password_confirmation => "" }
      end

      it "should render the 'edit' page"  do
        put :update, :id => @user, :user => @attr
	response.should render_template('edit')
      end

      it "should have the right title page"  do
        put :update, :id => @user, :user => @attr
	response.should have_selector("title", :content => "Edit user")
      end
    end

    describe "success" do
      before(:each) do
	@attr = {:email => "user@example.org", :name => "New Name", :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes"  do
        put :update, :id => @user, :user => @attr
	@user.reload
	@user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page"  do
        put :update, :id => @user, :user => @attr
	response.should redirect_to(user_path(@user))
      end

      it "should have a flash message"  do
        put :update, :id => @user, :user => @attr
	flash[:success].should =~ /updated/
      end      
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @invitation = Factory(:invitation)
      @user = Factory(:user)
    end

    describe "for non-signed in users" do
     
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end

    end

    describe "for signed in users" do

      before(:each) do
         @invitation = Factory(:invitation, :email => "user@example.net")
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
     
      it "should require matching users for edit" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end

    end

  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @invitation = Factory(:invitation)
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
         delete :destroy, :id => @user
         response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
         test_sign_in(@user)
         delete :destroy, :id => @user
         response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do
      
      before(:each) do
        @invitation = Factory(:invitation, :email => "admin@example.com", :access_code => "welcome_admin")
        admin = Factory(:user, :email => "admin@example.com", 
                                :welcome_code => "welcome_admin",
                                :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
	lambda do
	  delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
	  delete :destroy, :id => @user
	  response.should redirect_to(users_path)
      end
    end
  end
end

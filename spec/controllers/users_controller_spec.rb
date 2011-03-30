require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @base_title = "JoinOpp"
  end

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
      @full_name = @user.first_name + " " + @user.last_name
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
      response.should have_selector("title", :content => @full_name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @full_name)
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

end

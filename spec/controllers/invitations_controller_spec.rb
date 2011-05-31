require 'spec_helper'

describe InvitationsController do
  render_views

  describe "GET 'new'" do

    before(:each) do
      @invitation = Factory(:invitation)
      @undertaking = test_choose_undertaking(Factory(:undertaking))
      @user = test_sign_in(Factory(:user))
    end

    it "should be successful" do
      get 'new', :user_id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :new, :user_id => @user
      response.should have_selector("title", :content => "Invitations")
    end
  end

  describe "GET 'index'" do

    describe "for non-signed in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    
 end


end

require 'spec_helper'

describe InvitationsController do
  render_views

  before(:each) do
        @user = test_sign_in(Factory(:user))
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :user_id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :new, :user_id => @user
      response.should have_selector("title", :content => "Invitations")
    end
  end

end

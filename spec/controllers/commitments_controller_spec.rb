require 'spec_helper'

describe CommitmentsController do

  describe "access control" do
   
   it "should deny access to 'create'" do
    post :create
    response.should redirect_to(signin_path)
   end

   it "should deny access to 'destroy'" do
    post :destroy, :id => 1
    response.should redirect_to(signin_path)
   end

  end

 
  describe "POST 'create'" do

    before (:each) do
      @user = test_sign_in(Factory(:user))
    end
    it "should be successful" do
      post :create
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    before (:each) do
      @user = test_sign_in(Factory(:user))
      @undertaking = Factory(:undertaking)
      @commitment = @user.commitments.build(:undertaking_id => @undertaking)
      @commitment.save!
    end
    it "should be successful" do
      delete :destroy, :id => @commitment
      response.should be_success
    end
  end

end

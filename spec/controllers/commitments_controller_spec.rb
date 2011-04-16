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
      @undertaking = Factory(:undertaking)
    end
    it "should create a commitment" do
      lambda do
         post :create, :commitment => {:undertaking_id => @undertaking}
         response.should be_redirect
      end.should change(Commitment, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do
    before (:each) do
      @user = test_sign_in(Factory(:user))
      @undertaking = Factory(:undertaking)
      @user.devote!(@undertaking)
      @commitment = @user.commitments.find_by_undertaking_id(@undertaking)
    end
    it "should destroy a commitment" do
     lambda do
      delete :destroy, :id => @commitment
      response.should be_redirect
     end.should change(Commitment, :count).by(-1)
    end
  end

end

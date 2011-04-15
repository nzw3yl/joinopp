require 'spec_helper'

describe Commitment do
  
  before(:each) do
   @user = Factory(:user)
   @undertaking = Factory(:undertaking)

   @commitment = @user.commitments.build(:undertaking_id => @undertaking.id)
  end

  it "should create a new instance given valid attributes" do
     @commitment.save!
  end

  describe "commitment methods" do
    
   before(:each) do
     @commitment.save
   end

   it "should have a user attribute" do
     @commitment.should respond_to(:user)
   end

   it "should have the right user" do
     @commitment.user.should == @user
   end

   it "should have an undertaking attribute" do
     @commitment.should respond_to(:undertaking)
   end

   it "should have the right undertaking" do
     @commitment.undertaking.should == @undertaking
   end

  end

  describe "validations" do
   
    it "should require a user_id" do
     @commitment.user_id = nil
     @commitment.should_not be_valid
    end

    it "should require an undertaking_id" do
     @commitment.undertaking_id = nil
     @commitment.should_not be_valid
    end
  end
end

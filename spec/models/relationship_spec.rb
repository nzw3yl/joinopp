require 'spec_helper'

describe Relationship do

  before(:each) do
    @contributor = Factory(:undertaking)
    @contributed = Factory(:undertaking, :access_code => Factory.next(:access_code))

    @relationship = @contributor.relationships.build(:contributed_id => @contributed.id)
  end
  
 it "should create a new instance given valid attributes" do
  @relationship.save!
 end
  
 describe "contribute methods" do

   before(:each) do
     @relationship.save
   end

   it "should have a contributor attribute" do
     @relationship.should respond_to(:contributor)
   end

   it "should have the right contributor" do
     @relationship.contributor.should == @contributor
   end

   it "should have a contributed attribute" do
     @relationship.should respond_to(:contributed)
   end

   it "should have the right contributed undertaking" do
     @relationship.contributed.should == @contributed
   end
 end

 describe "validations" do
   
   it "should require a contributor_id" do
     @relationship.contributor_id = nil
     @relationship.should_not be_valid
   end

   it "should require a contributed_id" do
     @relationship.contributed_id = nil
     @relationship.should_not be_valid
   end
 end
end

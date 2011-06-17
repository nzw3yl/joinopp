require 'spec_helper'

describe Goal do
  
   before(:each) do
     @owner = Factory(:user)
     @goal = Factory(:goal)
     @attr = {
		:title => "first goal",
  		:description => "goal description",
		:user_id => 1
             }
   end

   it "should create a new instance given valid attributes" do
     Goal.create!(@attr)
   end

   describe "user associations" do
     before(:each) do
       @goal = @owner.goals.create(@attr)
     end

     it "should have a user attribute" do

       @goal.should respond_to(:user)
     end

     it "should have the right associated user" do
       @goal.user_id.should == @owner.id
       @goal.user.should == @owner
     end
   end

   describe "validations" do
     
     it "should require a user id" do
       @no_user_attr = {
		:title => "first goal",
  		:description => "goal description"
		   }
       Goal.new(@no_user_attr).should_not be_valid   
     end


     it "should require a nonblank title" do
       @no_title_attr = {
		:title => " ",
  		:description => "goal description"
		   }
       @owner.goals.build(@no_title_attr).should_not be_valid
     end


     it "should reject a long title" do
       @long_title_attr = {
		:title => "a" * 51,
  		:description => "goal description"
		   }
       @owner.goals.build(@long_title_attr).should_not be_valid
     end


     it "should require a nonblank description" do
       @no_description_attr = {
		:title => "first goal",
  		:description => " "
		   }
       @owner.goals.build(@no_description_attr).should_not be_valid
     end
   end
   
end

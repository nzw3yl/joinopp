require 'spec_helper'

describe Invitation do
  
  before(:each) do
    @invitation_er = Factory(:invitation)
    @invitation_ee = Factory(:invitation, :email => Factory.next(:i_email))
    @inviter = Factory(:user)
    @invitee = Factory(:user, :email => Factory.next(:email))

    @invitation = @inviter.invitations.build(:invitee_id => @invitee.id)

  end

  it "should create a new instance given valid attributes" do
    @invitation.save!
  end

  describe "inviter methods" do
   
   before(:each) do
     @invitation.save
   end

   it "should have an inviter attribute" do
    @invitation.should respond_to(:inviter)
   end

   it "should have the right inviter" do
    @invitation.inviter.should == @inviter
   end

   it "should have an invitee attribute" do
    @invitation.should respond_to(:invitee)
   end

   it "should have the right invitee" do
    @invitation.invitee.should == @invitee
   end

  end

  describe "validations" do
 
   it "should require an inviter_id" do
    @invitation.inviter_id = nil
    @invitation.should_not be_valid
   end
  end


end

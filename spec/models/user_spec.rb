require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
 		:name => "Example", 
		:welcome_code => "User", 
		:email => "user@example.com",
		:password => "foobar",
		:password_confirmation => "foobar" 
	     }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a welcome_code" do
    no_welcome_code_user = User.new(@attr.merge(:welcome_code => ""))
    no_welcome_code_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should reject welcome_codes that are too long" do
    welcome_code = "a" * 51
    welcome_code_user = User.new(@attr.merge(:welcome_code => welcome_code))
    welcome_code_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp ]
    addresses.each do |address|
       valid_email_user = User.new(@attr.merge(:email => address))
       valid_email_user.should be_valid
    end
  end

  it "should not accept invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. ]
    addresses.each do |address|
       invalid_email_user = User.new(@attr.merge(:email => address))
       invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end	

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      
      it "should be true if the passwords match" do
         @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
         @user.has_password?("invalid").should be_false
      end

    end

    describe "authentication method" do
      
      it "should return nil on email/password mismatch" do
         wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
         wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
         nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
         nonexistent_user.should be_nil
      end  

      it "should return the user on email/password match" do
         wrong_password_user = User.authenticate(@attr[:email], @attr[:password])
         wrong_password_user.should == @user
      end

    end

  end

  describe "admin attribute" do
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
       @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "commitments" do
    
    before(:each) do
      @user = User.create!(@attr)
      @undertaking = Factory(:undertaking)
    end

    it "should have a commitments method" do
      @user.should respond_to(:commitments)
    end

    it "should have a committed? method" do
      @user.should respond_to(:committed_to?)
    end

    it "should have a devote! method" do
     @user.should respond_to(:devote!)
    end

    it "should commit a user" do
     @user.devote!(@undertaking)
     @user.should be_committed_to(@undertaking)
    end

    it "should include the undertaking in the undertaking array" do
     @user.devote!(@undertaking)
     @user.undertakings.should include(@undertaking)
    end

    it "should have an abandon! method" do
     @user.should respond_to(:abandon!)
    end

    it "should abandon a commitment" do
     @user.devote!(@undertaking)
     @user.abandon!(@undertaking)
     @user.should_not be_committed_to(@undertaking)
    end
  end

  describe "invitations" do

   before(:each) do
    @user = User.create!(@attr)
    @invitee = Factory(:user)
    @undertaking = Factory(:undertaking)
   end

   it "should have an invitations method" do
     @user.should respond_to(:invitations)
   end

   it "should have an inviters method" do
    @user.should respond_to(:inviters)
   end 

   it "should have an inviter? method" do
    @user.should respond_to(:inviter?)
   end

   it "should have an invite! method" do
    @user.should respond_to(:invite!)
   end

   it "should invite another user" do
    @user.invite!(@invitee, @undertaking)
    @user.should be_inviter(@invitee, @undertaking)
   end

   it "should include the invitee in the invitees array" do
    @user.invite!(@invitee, @undertaking)
    @user.invitees.should include(@invitee)
   end

   it "should have an uninvite! method" do
    @invitee.should respond_to(:uninvite!)
   end  
  
   it "should uninvite a user" do
    @user.invite!(@invitee, @undertaking)
    @user.uninvite!(@invitee, @undertaking)
    @user.should_not be_inviter(@invitee, @undertaking)
   end

   it "should have a reverse_invitations method" do
    @user.should respond_to(:reverse_invitations)
   end

   it "should have an invitees method" do
    @user.should respond_to(:invitees)
   end

   it "should inlcude the inviter in the inviters array" do
    @user.invite!(@invitee, @undertaking)
    @invitee.inviters.should include(@user)
   end
  end

end

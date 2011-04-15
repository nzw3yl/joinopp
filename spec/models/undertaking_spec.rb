require 'spec_helper'

describe Undertaking do
  
  before(:each) do
    @attr = {
	:title 		=> "undertaking title",
        :description	=> "undertaking description",
  	:success_if	=> "undertaking success",
	:access_code	=> "welcome"
            }
  end

  it "should create a new instance of an undertaking given valid attributes" do
	Undertaking.create!(@attr)
  end
  
  describe "validations" do

	  it "should not create an undertaking without a valid title" do
		no_title_undertaking = Undertaking.new(@attr.merge(:title => ""))
		no_title_undertaking.should_not be_valid
	  end

	  it "should reject short titles" do
	      short = "a" * 5
	      hash = @attr.merge(:title => short)
	      Undertaking.new(hash).should_not be_valid
	    end

	  it "should reject long titles" do
	      long = "a" * 141
	      hash = @attr.merge(:title => long)
	      Undertaking.new(hash).should_not be_valid
	  end

	  it "should not create an undertaking without a valid description" do
		no_description_undertaking = Undertaking.new(@attr.merge(:description => ""))
		no_description_undertaking.should_not be_valid
	  end

	  it "should reject short descriptions" do
	      short = "a" * 5
	      hash = @attr.merge(:description => short)
	      Undertaking.new(hash).should_not be_valid
	    end

	  it "should reject long descriptions" do
	      long = "a" * 256
	      hash = @attr.merge(:description => long)
	      Undertaking.new(hash).should_not be_valid
	  end
  end

  describe "commitments" do
    
    before(:each) do
      @undertaking = Undertaking.create!(@attr)
      @user = Factory(:user)
    end

    it "should have a commitments method" do
      @undertaking.should respond_to(:commitments)
    end

    it "should have a users method" do
      @undertaking.should respond_to(:users)
    end

    it "should include the users in the users array" do
     @user.devote!(@undertaking)
     @undertaking.users.should include(@user)
    end
  end

end

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

  describe "relationships" do

    before(:each) do
      @undertaking = Undertaking.create!(@attr)
      @contributed = Factory(:undertaking)
    end

    it "should have a relationship method" do
     @undertaking.should respond_to(:relationships)
    end

    it "should have a contributing method" do
     @undertaking.should respond_to(:contributing)
    end

    it "should have a contributing? method" do
     @undertaking.should respond_to(:contributing?)
    end

    it "should have a contribute! method" do
     @undertaking.should respond_to(:contribute!)
    end

    it "should contribute to another undertaking" do
     @undertaking.contribute!(@contributed)
     @undertaking.should be_contributing(@contributed)
    end

    it "should include the contributed undertaking in the contributing array" do
     @undertaking.contribute!(@contributed)
     @undertaking.contributing.should include(@contributed)
    end

    it "should have a withhold! method" do
     @contributed.should respond_to(:withhold!)
    end

    it "should sever an undertaking" do
     @undertaking.contribute!(@contributed)
     @undertaking.withhold!(@contributed)
     @undertaking.should_not be_contributing(@contributed)
    end
    
    it "should have reverse relationships method" do
      @undertaking.should respond_to(:reverse_relationships)
    end

    it "should have a contributors method" do
      @undertaking.should respond_to(:contributors)
    end

    it "should include the contributor in the contributors array" do
      @undertaking.contribute!(@contributed)
      @contributed.contributors.should include(@undertaking)
    end
  end

  describe "goal associations" do
    before(:each) do
     @goal = Factory(:goal)
     @undertaking = @goal.undertakings.create!(@attr)
    end

    it "should have a goal attribute" do
     @undertaking.should respond_to(:goal)
    end

    it "should have the right associated goal" do
      @undertaking.goal_id.should == @goal.id
      @undertaking.goal.should == @goal
    end
  end
end

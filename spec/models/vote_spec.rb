require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do
  before(:each) do
    @valid_attributes = {
      :vote => 1,
      :voteable => mock_model(Question),
      :user => mock_model(User)
    }
  end

  describe "associations" do
    it "should belong to user" do
      Vote.should belong_to(:user)
    end
    it "should belong to voteable as a polymorphic" do
      Vote.should belong_to(:voteable , :polymorphic => true, :foreign_type => "voteable_type")
    end
    
  end

  describe "validations" do
    it "should create a new instance given valid attributes" do
      @vote = Vote.new(@valid_attributes)
      @vote.should be_valid
    end
    
    it "should require the user" do
      @vote = Vote.new(@valid_attributes.merge(:user => nil))
      @vote.should_not be_valid
    end
    
    it "should require the voteable" do
      @vote = Vote.new(@valid_attributes.merge(:voteable => nil))
      @vote.should_not be_valid
    end
    
    it "should require the vote" do
      @vote = Vote.new(@valid_attributes.merge(:vote => nil))
      @vote.should_not be_valid
    end
   
    it "should vote be -1 or 1" do
      @vote = Vote.new(@valid_attributes.merge(:vote => 2))
      @vote.should_not be_valid
    end
    
    it "should vote be unique for the user with scope for voteable" do
      @vote = Vote.create!(@valid_attributes)
      @vote = Vote.new(@valid_attributes)
      @vote.should_not be_valid
    end
    
  end  
end

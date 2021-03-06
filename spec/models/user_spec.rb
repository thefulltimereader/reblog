require 'spec_helper'


describe User do 

  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" , 
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    noname = User.new(@attr.merge(:name => ""))
    noname.should_not be_valid
  end

  it "should reject naames that are too long" do
    long_name = "a"*51
    long_name_user = User.new(@attr.merge(:name=> long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addr = %w[user@foo.com user@foo.bar.org first.last@foo.jp]
    addr.each do |address|
      valid_user = User.new(@attr.merge(:email => address))
      valid_user.should be_valid
    end
  end

  it "should not accept invalid email addresses" do
    addr = %w[user.com user.,org first.last@foo.]
    addr.each do |address|
      invalid_user = User.new(@attr.merge(:email => address))
      invalid_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid

    user_with_duplicate_email_upcase = User.new(@attr[:email].upcase)
    user_with_duplicate_email_upcase.should_not be_valid

  end

  describe "password validations" do
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
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

    describe "password encryption" do
      before(:each) do
        @user = User.create!(@attr)
      end
      
      it "should have an encrypted password attribute" do
        @user.should respond_to(:encrypted_password)
      end

      it "should set the encrypted password" do
        @user.encrypted_password.should_not be_blank
      end
    end
    
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end

    end
    
    describe "authenticate method" do
      
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end

    end # of describe "authenticate method" do
  end # of password validations
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

  end # of describe "admin attribue"
  

  describe "post associations" do
    before(:each) do
      @user = User.create(@attr)
      @mp1 = Factory(:post, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:post, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a posts attribute" do
      @user.should respond_to(:posts)
    end

    it "should have the right posts in the right order" do
      @user.posts.should == [@mp2, @mp1]
    end

    it "should destroy associated posts" do
      @user.destroy
      [@mp1, @mp2].each do |post|
        Post.find_by_id(post.id).should be_nil
      end      
    end

    describe "status feed" do
      it "should have a feed" do
        @user.should respond_to(:feed)
      end
      it "should include the user's posts" do
        @user.feed.include?(@mp1).should be_true
        @user.feed.include?(@mp2).should be_true
      end
      it "should not include a different user's posts" do
        mp3 = Factory(:post,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(mp3).should be_false
      end
    end
  end # of post associations
end

require 'spec_helper'


describe User do 

  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
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


end

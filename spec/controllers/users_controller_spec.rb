require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => "sign up")
    end
  end

  describe "GET 'show'" do

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      # rails does id=> @user.id by itself
      assigns(:user).should == @user
      #assigns takes a symbol arg and ret the val of the corr. instance var i.e. @user
    end
      
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
    
  end
end

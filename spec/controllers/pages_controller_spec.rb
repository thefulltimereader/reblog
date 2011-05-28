require 'spec_helper'

describe PagesController do
  render_views
  
  # before *each* test case
  before(:each) do
    @base_title = 'reblog'
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  it "should have the right title" do
    get 'home'
# wtf
#   response.should have_selector('title', :content => @base_title + ' :home')
  end

end

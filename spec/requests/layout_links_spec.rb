require 'spec_helper'

describe "LayoutLinks" do

  it "should have a HOME page at '/'" do
    get '/'
    response.should have_selector('title', :content => 'home')
  end

  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => 'contact')
  end

  it "should have a about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => 'about')
  end
end

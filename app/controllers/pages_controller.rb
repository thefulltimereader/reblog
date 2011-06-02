class PagesController < ApplicationController
  
  # def initialize(attributes = {})
  #   @reblog_title = "Research Log"
  # end
  def home
    @title = "Reblog:home"
  end

  def about
    @title = "Reblog:about"
  end

  def contact
    @title = "Reblog:contact"
  end

end

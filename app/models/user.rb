# == Schema Information
# Schema version: 20110528052442
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates_presence_of :name, :email
  has_many :posts

  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  # same as validates(:name, :presence => true, :length=>{:maximum=>50})

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,:format   => { :with => email_regex }, 
  :uniqueness => { :case_sensitive => false }
  
  
end

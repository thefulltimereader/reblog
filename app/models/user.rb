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
  attr_accessor :password
  attr_accessible :name, :emal, :password, :password_confirmation
  
  before_save :encrypt_password
#  validates_presence_of :name, :email
  has_many :posts

  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  # same as validates(:name, :presence => true, :length=>{:maximum=>50})

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,:format   => { :with => email_regex }, 
  :uniqueness => { :case_sensitive => false }
 
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  private
   
     def encrypt_password
       self.encrypted_password = encrypt(password)
     end
     
     def encrypt
       string #tmp
     end
end

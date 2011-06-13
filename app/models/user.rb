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
require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
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

  def self.authenticate(email, submitted_pass)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user: nil
# same as:  return nil if user.nil?
#    return user if user.has_password?(submitted_pass)
  end

  private
   
     def encrypt_password
       puts "at encrypt_password"
       self.salt = make_salt if new_record?
       self.encrypted_password = encrypt(password)
     end
     
     def encrypt(string)
       secure_hash("#{salt}--#{string}")
     end

     def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
     end

     def secure_hash(string)
       Digest::SHA2.hexdigest(string)
     end
end

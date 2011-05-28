class User < ActiveRecord::Base
  validates_presence_of :name, :email
  has_many :posts
end

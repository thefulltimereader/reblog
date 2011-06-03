# == Schema Information
# Schema version: 20110528052442
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base  
  belongs_to :user
  
  validates_presence_of :title,:body
  
end

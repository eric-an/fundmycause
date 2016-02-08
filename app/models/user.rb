class User < ActiveRecord::Base
  has_many :user_causes
  has_many :causes, through: :user_causes
  
  validates_presence_of :email, :password, :name
  has_secure_password
end
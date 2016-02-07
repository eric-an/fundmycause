class Cause < ActiveRecord::Base
  belongs_to :category
  has_many :user_causes
  has_many :users, through: :user_causes
end
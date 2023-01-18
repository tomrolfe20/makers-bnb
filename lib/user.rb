class User < ActiveRecord::Base
  has_many :space
  has_many :booking
  validates_uniqueness_of :user_name
  validates_uniqueness_of :email
end

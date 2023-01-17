class User < ActiveRecord::Base
  has_many :space
  has_many :booking
end

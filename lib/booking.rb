class Booking < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
end

# encrypted_password = BCrypt::Password.create(params["password"])

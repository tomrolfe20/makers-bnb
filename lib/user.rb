class User < ActiveRecord::Base
  # has_secure_password
end

# encrypted_password = BCrypt::Password.create(params["password"])

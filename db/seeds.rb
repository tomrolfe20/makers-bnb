require 'faker'

Faker::Config.random = Random.new(10)

if ENV['RACK_ENV'] == 'test'
  10.times do
    fake_data = Faker::Internet.unique.user('username', 'email', 'password')
    User.create(
      user_name: fake_data[:username],
      email: fake_data[:email],
      password: fake_data[:password]
    )
  end

end



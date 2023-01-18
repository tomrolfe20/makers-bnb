if ENV['RACK_ENV'] == 'test'
  User.create(
    user_name: "name",
    email: "name@example.email",
    password: "pass123"
  )
  User.create(
    user_name: "name2",
    email: "name2@example.email",
    password: "pass123"
  )
  User.create(
    user_name: "name3",
    email: "name3@example.email",
    password: "pass123"
  )
  Space.create(
    name: "Hotel Makers",
    description: "Ikea",
    price_per_night: 200,
    user_id: 1
  )
  Space.create(
    name: "Hotel Hilton",
    description: "Fancy",
    price_per_night: 1000,
    user_id: 2
  )
  Space.create(
    name: "Holiday inn",
    description: "just a bed",
    price_per_night: 100,
    user_id: 3
  )
  Booking.create(
    date: "2023-01-01",
    available: false,
    space_id: 1,
    user_id: 1
  )
  Booking.create(
    date: "2023-01-01",
    available: true,
    space_id: 2,
    user_id: 2
  )
  Booking.create(
    date: "2023-01-01",
    available: false,
    space_id: 3,
    user_id: 3
  )
else
  User.create(
    user_name: "name",
    email: "name@example.email",
    password: "pass123"
  )
end

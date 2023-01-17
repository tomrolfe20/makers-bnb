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
  User.create(
    user_name: "name4",
    email: "name4@example.email",
    password: "pass123"
  )
  User.create(
    user_name: "name5",
    email: "name5@example.email",
    password: "pass123"
  )
  Space.create(
    name: "Hotel Makers",
    description: "Ikea",
    price_per_night: 200,
    host_name: "Makers"
  )
  Space.create(
    name: "Hotel Hilton",
    description: "Fancy",
    price_per_night: 1000,
    host_name: "Hilton"
  )
  Space.create(
    name: "Holiday inn",
    description: "just a bed",
    price_per_night: 100,
    host_name: "Company Holiday"
  )
  Space.create(
    name: "Hotel I",
    description: "Bog standard hotel",
    price_per_night: 150,
    host_name: "Company I"
  )
  Booking.create(
    date: "2023-01-01",
    available: true
  )
  Booking.create(
    date: "2023-02-14",
    available: true
  )
  Booking.create(
    date: "2023-03-20",
    available: false
  )
end
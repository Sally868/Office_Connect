# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'vivien@gmail.com', password: '123456')
user2 = User.create(email: "george@gmail.com", password: "123456")

venue = Venue.create(name: "Inspire9", address: "42 stewart street, richmond", user: user)
venue = Venue.create(name: "InspireCoders", address: " 32 erin street, richmond", user: user)

space = Space.create(name:"Meeting room", capacity:8, venue: venue)
space = Space.create(name:"Open desk", capacity:12, venue: venue)
space = Space.create(name:"Classroom", capacity:10, venue: venue)

Booking.create(start: DateTime.now, finish: DateTime.now + 1.hours, space: space, user: user2)

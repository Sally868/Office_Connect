# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'vivien@gmail.com', password: '123456')
user2 = User.create(email: "george@gmail.com", password: "123456")

venue = Venue.create(name: "Inspire9", address: "42 Stewart street, richmond", user: user)
venue1 = Venue.create(name: "InspireCoders", address: "32 Erin street, richmond", user: user2)
venue2 = Venue.create(name: "99 Designs", address: "42 stewart street, richmond", user: user2)

Space.create(name: "Meeting room", capacity: 8, venue: venue, description: "A spacious room perfect for groups.")
Space.create(name: "Open desk", capacity: 12, venue: venue, description: "A spacious room perfect for groups.")
Space.create(name: "Classroom", capacity: 10, venue: venue, description: "A spacious room perfect for groups.")

Space.create(name: "Meeting room", capacity: 8, venue: venue1, description: "A spacious room perfect for groups.")
Space.create(name: "Open desk", capacity: 12, venue: venue1, description: "A spacious room perfect for groups.")
Space.create(name: "Classroom", capacity: 10, venue: venue1, description: "A spacious room perfect for groups.")

Space.create(name: "Meeting room", capacity: 8, venue: venue2, description: "A spacious room perfect for groups.")
Space.create(name: "Open desk", capacity: 12, venue: venue2, description: "A spacious room perfect for groups.")
Space.create(name: "Classroom", capacity: 10, venue: venue2, description: "A spacious room perfect for groups.")

Booking.create(start: DateTime.now, finish: DateTime.now + 1.hours, space: space, user: user2)

venue_images = ['https://images.squarespace-cdn.com/content/v1/5cabdc9c809d8e269de92d7b/1608236340236-T11B5WOB09W1UVRVZ20Q/Dedicated+Desk?format=750w',
'https://images.squarespace-cdn.com/content/v1/5cabdc9c809d8e269de92d7b/1608236754054-4G1LTLCHVPEVX92258O6/Flexible+co-working+options?format=750w',
'https://images.squarespace-cdn.com/content/v1/5cabdc9c809d8e269de92d7b/1608237686493-SI56Z0YCTSFT70GLUZOY/20190708_Inspire9_0001.jpg?format=750w']

space_images = ['https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
'https://images.unsplash.com/photo-1606857521015-7f9fcf423740?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
'https://images.unsplash.com/photo-1604328698692-f76ea9498e76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
'https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80',
'https://images.unsplash.com/photo-1497366811353-6870744d04b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80',
'https://images.unsplash.com/photo-1564069114553-7215e1ff1890?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80',
'https://images.unsplash.com/photo-1517502884422-41eaead166d4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1325&q=80',
'https://images.unsplash.com/photo-1497215842964-222b430dc094?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
'https://images.unsplash.com/photo-1555212697-194d092e3b8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80']

Venue.all.each_with_index do |venue, index|
  url = venue_images[index]
  file = URI.open(url)
  venue.photos.attach(io: file, filename: "#{venue.name}.jpg", content_type: "image/jpg")
  venue.save
end

Space.all.each_with_index do |space, index|
  url = space_images[index]
  file = URI.open(url)
  space.photo.attach(io: file, filename: "#{space.name}.jpg", content_type: "image/jpg")
  space.save
end

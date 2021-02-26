require 'open-uri'
require 'nokogiri'
require 'faker'
require "yaml"
require 'date'

puts "Destroying all instances"
Cruise.destroy_all
Boat.destroy_all
Booking.destroy_all
Location.destroy_all
User.destroy_all
# Review.destroy_all
# Message.destroy_all

puts "done destroying"

# user1 = User.create!(email: "user1@gmail.com", password: 123456)
# user2 = User.create!(email: "user2@gmail.com", password: 123456)

  2.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = "123456"

  user = User.create!(email: email, password: password)

  user_photo_url = "https://thispersondoesnotexist.com/image"
  user_photo_file = URI.open(user_photo_url)
  user.photo.attach(io: user_photo_file, filename: "user_photo")
end

boats = [{
  name: "Cash à l'eau",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/0lly6fazbt45f0pmeav1ysmoq36dexvv.big.jpg.gz",
  category: "Sun Odissey 349",
  capacity: 6,
  user: User.last
},
{
  name: "Ode mer",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/7k56w3ksiells2bia9fp75q0wlym1w64.big.jpg.gz",
  category: "Lagoon 420",
  capacity: 8,
  user: User.last
},
{
  name: "Patpau",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/18hjmkt8vm6kdnyvsrf8zwh5gnwi12ax.big.jpg.gz",
  category: "Bahia 46",
  capacity: 8,
  user: User.last
},
{
  name: "Lashepriz",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/k1hi4mveo5i36s49i666gwb0e1uthpnf.big.jpg.gz",
  category: "Feeling 32",
  capacity: 4,
  user: User.last
},
{
  name: "Nages et tais toi",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/lfp29o37ywzht0zp6xq2flhfe6blf6hr.big.jpg.gz",
  category: "Dufour 45 Performance",
  capacity: 8,
  user: User.last
},
{
  name: "Almaco IV",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/ol31joo5zngi85kp9kpl5jx3aubbgata.big.jpg.gz",
  category: "Laboe 51",
  capacity: 6,
  user: User.last
},
{
  name: "Croque le vent",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/te2yJvd38oNcvPy53Bh5dxpQP6VsTR1d.big.jpg.gz",
  category: "Sense 55",
  capacity: 8,
  user: User.last
},
{
  name: "Altaîr",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/1pd04n9y42m0k0mq9h2rcvvew9lmgfy8.big.jpg.gz",
  category: "Bali 4.1",
  capacity: 8,
  user: User.last
},
{
  name: "Mangareva",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/0gZs8iCPiz5gPymwqDjlYZs9gfaqODGW.big.jpg.gz",
  category: "Fontaine Pajot 40 Lucia",
  capacity: 4,
  user: User.last
},
{
  name: "Vaîmiti",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/5ie0mx2juawys96g0dzl898hbgnuo6p9.big.jpg.gz",
  category: "Sun-Fast 39",
  capacity: 6,
  user: User.last
}]

boats.each do |boat|
  boaty = Boat.new(boat)
  p boaty
  boaty.valid?
  boaty.save!
  # boaty.photos.attach(boaty.photo)
end

ajaccio = Location.new(name: "Ajaccio")
ajaccio.save!

porto_vecchio = Location.new(name: "Porto Vecchio")
porto_vecchio.save!

ibiza = Location.new(name: "Ibiza")
ibiza.save!

la_maddalena = Location.new(name: "La Maddalena")
la_maddalena.save!

cagliari = Location.new(name: "Cagliari")
cagliari.save!

palma = Location.new(name: "Palma")
palma.save!

palerme = Location.new(name: "Palerme")
palerme.save!

marseille = Location.new(name: "Marseille")
marseille.save!




cruises = [{

  name: "Sicilia, eterna primavera!",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},

{
  name: "C'est Marseille bb",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},
{
  name: "Nice trip all around Corsica",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},

{
  name: "Sailing to Palma, le Corazon des baléares",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
},

{
  name: "Ciao Sardegna",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},
{
  name: "Ibiza le berceau de la Fiesta",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  start_location: Location.all.sample,
  end_location: Location.all.sample,
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
}
]


cruises.each do |cruise|
  cruisy = Cruise.new(cruise)
  p cruisy
  cruisy.boat = Boat.first
  cruisy.valid?
  cruisy.save!
  # boaty.photos.attach(boaty.photo)
end



  # activity = ["scuba diving", "paddle", "Canoe", "water skiing"].sample


  # price = rand(10..40)


  # file = URI.open(image_url)

# end

puts "#{User.all.length} users created"
puts "#{Boat.all.length} boats created"
puts "#{Cruise.all.length} cruises created"


# board image to do after cloudinary setup
# image_url = html_doc.at('.image-inset img').attribute('src').value

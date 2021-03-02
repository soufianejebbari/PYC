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

5.times do
  first_name = Faker::Name.first_name
  email = Faker::Internet.email
  password = "123456"

  user = User.create!(first_name: first_name, email: email, password: password)

  user_photo_url = "https://thispersondoesnotexist.com/image"
  user_photo_file = URI.open(user_photo_url)
  user.photo.attach(io: user_photo_file, filename: "user_photo")
end

boats = [{
  name: "Cash à l'eau",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/0lly6fazbt45f0pmeav1ysmoq36dexvv.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1498623116890-37e912163d5d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
  category: "Sun Odissey 349",
  capacity: 6,
  user: User.by_random.first
},
{
  name: "Ode mer",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/7k56w3ksiells2bia9fp75q0wlym1w64.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1533690251914-dd6880431ed0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
  category: "Lagoon 420",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Patpau",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/18hjmkt8vm6kdnyvsrf8zwh5gnwi12ax.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1573925805234-22b9e43a5450?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1647&q=80",
  category: "Bahia 46",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Lashepriz",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/k1hi4mveo5i36s49i666gwb0e1uthpnf.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1536926272733-fd11abd4e4fd?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1650&q=80",
  category: "Feeling 32",
  capacity: 4,
  user: User.by_random.first
},
{
  name: "Nages et tais toi",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/lfp29o37ywzht0zp6xq2flhfe6blf6hr.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1561562176-d1d598e49589?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
  category: "Dufour 45 Performance",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Almaco IV",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/ol31joo5zngi85kp9kpl5jx3aubbgata.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1505493018155-f43ad2a7845b?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1567&q=80",
  category: "Laboe 51",
  capacity: 6,
  user: User.by_random.first
},
{
  name: "Croque le vent",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/te2yJvd38oNcvPy53Bh5dxpQP6VsTR1d.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1593346362801-b638bed56187?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2689&q=80",
  category: "Sense 55",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Altaîr",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/1pd04n9y42m0k0mq9h2rcvvew9lmgfy8.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1558384857-10929afd041c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1651&q=80",
  category: "Bali 4.1",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Mangareva",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/0gZs8iCPiz5gPymwqDjlYZs9gfaqODGW.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1613578699399-82ae71be53a3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1953&q=80",
  category: "Fontaine Pajot 40 Lucia",
  capacity: 4,
  user: User.by_random.first
},
{
  name: "Vaîmiti",
  description: Faker::Lorem.paragraph,
  # photo: "https://static1.clickandboat.com/v1/p/5ie0mx2juawys96g0dzl898hbgnuo6p9.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1542736267-fb6ea61a2e17?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
  category: "Sun-Fast 39",
  capacity: 6,
  user: User.by_random.first
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
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},

{
  name: "C'est Marseille bb",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},
{
  name: "Nice trip all around Corsica",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},

{
  name: "Sailing to Palma, le Corazon des baléares",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
},

{
  name: "Ciao Sardegna",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},
{
  name: "Ibiza le berceau de la Fiesta",
  description: Faker::Lorem.paragraph,
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
}
]


cruises.each do |cruise|
  cruisy = Cruise.new(cruise)
  p cruisy
  cruisy.stops.new(location: Location.by_random.first, start_location: true)
  (0..3).to_a.sample.times do
    cruisy.stops.new(location: Location.by_random.first)
  end
  cruisy.stops.new(location: Location.by_random.first, end_location: true)
  cruisy.boat = Boat.by_random.first
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

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
Review.destroy_all
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
  name: "Cash a l'eau",
  description: "The Sun Odyssey 349 is characterised by the purity of its lines, its interior volume and its welcoming cockpit. It perfectly combines performance, safety at sea and comfort. In the cockpit as well as at the helm, at anchor as well as at sea, take full advantage of this stable and very smooth sailing yacht. Escape from the daily grind and enjoy the pleasures of cruising !",
  # photo: "https://static1.clickandboat.com/v1/p/0lly6fazbt45f0pmeav1ysmoq36dexvv.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1498623116890-37e912163d5d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
  category: "monocoque",
  capacity: 6,
  user: User.by_random.first
},
{
  name: "Ode mer",
  description: "The Lagoon 420, with a length of 13 meters and a beam of almost 8 meters, offers more than 100m2 of surface area to the delight of our crew.This superb is characterized by its incredible interior layout which allows it to have 4 cabins with en-suite bathrooms, each equipped with a separate toilet and shower with hot water.et de douche avec eaux chaudes indépendants.",
  # photo: "https://static1.clickandboat.com/v1/p/7k56w3ksiells2bia9fp75q0wlym1w64.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1533690251914-dd6880431ed0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
  category: "catamaran",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Patpau",
  description: "For long distance sailing, the Bahia 46 is ideal. Stable, capable of great autonomy thanks to its generous volumes of water, fuel and food storage. It combines the speed of a catamaran, with good performance in light winds, with elements of comfort thought out in every detail : easy harbour manoeuvres with its two 38 HP engines, spacious cabins, a very convivial gondola with its vast and very well equipped galley, large fresh water tanks. Worthy of a hotel !",
  # photo: "https://static1.clickandboat.com/v1/p/18hjmkt8vm6kdnyvsrf8zwh5gnwi12ax.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1573925805234-22b9e43a5450?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1647&q=80",
  category: "catamaran",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Lashepriz",
  description: "For the purists, the Feeling 32 is a habitable cruising monohull. This pivoting daggerboard yacht, rigged as a split Sloop, is 9.68 m long and has a maximum draught of 1.9 m which favours anchorages close to the beaches.It offers a comfortable navigation and a spacious interior (good headroom), comfortable and pleasant.",
  # photo: "https://static1.clickandboat.com/v1/p/k1hi4mveo5i36s49i666gwb0e1uthpnf.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1536926272733-fd11abd4e4fd?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1650&q=80",
  category: "monocoque",
  capacity: 4,
  user: User.by_random.first
},
{
  name: "Nages et tais toi",
  description: "The Dufour 45E performance is a racing-cruising monohull. This yacht is 13.6 m long with a maximum draught of 570 m. Production started in 2010. 91 copies of the boat have been produced. The interior with its volumes and fittings are worthy of a large cruising yacht.",
  # photo: "https://static1.clickandboat.com/v1/p/lfp29o37ywzht0zp6xq2flhfe6blf6hr.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1561562176-d1d598e49589?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
  category: "monocoque",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Almaco IV",
  description: "This Laboe 51, german-built boat, is very little slack, all in wood, she has the look of an old rigging which makes all her charm. She has 3 cabins and a total of 6 berths, but is approved for 11 people for day trips.",
  # photo: "https://static1.clickandboat.com/v1/p/ol31joo5zngi85kp9kpl5jx3aubbgata.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1505493018155-f43ad2a7845b?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1567&q=80",
  category: "ketch",
  capacity: 6,
  user: User.by_random.first
},
{
  name: "Croque le vent",
  description: "If the birth of the Sense was the signature mark of a new lifestyle at sea, the Sense 55 brings the boundary between cruising and long-distance sailing even closer. This Beneteau yacht is an invitation to enjoy living at sea to its full, in harmony with our personal values. Succumb to the magic of a long voyage or coastal navigation, on board a boat in which you experience luxury, linking the essential with the timeless, quite simply and naturally.",
  # photo: "https://static1.clickandboat.com/v1/p/te2yJvd38oNcvPy53Bh5dxpQP6VsTR1d.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1593346362801-b638bed56187?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2689&q=80",
  category: "monocoque",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Altair",
  description: "The BALI 4.1 is the first sailing catamaran, totally decked from its bows to its transoms, offering a living space that is completely open and very ergonomic. It also offers a vast forward cockpit with sunbathing area, a breathtaking roof relaxation area, a platform linking the two aft skirts with a large bench seat and general comfort worthy of a large catamaran.",
  # photo: "https://static1.clickandboat.com/v1/p/1pd04n9y42m0k0mq9h2rcvvew9lmgfy8.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1558384857-10929afd041c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1651&q=80",
  category: "catamaran",
  capacity: 8,
  user: User.by_random.first
},
{
  name: "Mangareva",
  description: "A 40-FOOT SAILING CATAMARAN IDEAL FOR FAMILY CRUISES ! Always in the spirit of Fountaine Pajot's innovative design, this model offers you its modern saloon, its remarkable performance and its habitability to suit all tastes.  Decidedly, it has everything to please! Be the first to treat yourself to the freedom of escape and the pleasure of sailing in small groups, with family or friends.",
  # photo: "https://static1.clickandboat.com/v1/p/0gZs8iCPiz5gPymwqDjlYZs9gfaqODGW.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1613578699399-82ae71be53a3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1953&q=80",
  category: "catamaran",
  capacity: 4,
  user: User.by_random.first
},
{
  name: "Vaimiti",
  description: "The Sun-Fast 39 is a 12m sailboat Race/Cruise ; full-equipped with 3 double cabins, saloon with dining table, kitchen (fridge, oven and double sink), chart table, shower room and WC. Hot water. On the technical side : genoa 53 m² on furler, mainsail 42 m² and 3 spinnakers of 110 m². Fishing rods and snorkelling equipment.",
  # photo: "https://static1.clickandboat.com/v1/p/5ie0mx2juawys96g0dzl898hbgnuo6p9.big.jpg.gz",
  photo: "https://images.unsplash.com/photo-1542736267-fb6ea61a2e17?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
  category: "monocoque",
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

  name: "Corsica - Sardinia - Baleares Islands",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},

{
  name: "Corsica to Sardinia",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+2
},
{
  name: "Nice trip all around Corsica",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},

{
  name: "Sailing to Palma",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
},

{
  name: "Ciao Sardegna",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+1
},
{
  name: "Ibiza le berceau de la Fiesta",
  description: "A translucent sea, warm winds and the pleasure of being at sea. Whether you're a beginner looking for a mooring, or a seasoned sailor, we have the sailboat cruise of your dreams whatever your level of experience. Cruising is an itinerant activity aboard a habitable sailing boat on which you sail autonomously, stopping at well-chosen ports or anchorages. The crew ensures the smooth running of the boat during the navigation.",
  difficulty: rand(1..5),
  price: rand(90..300),
  start_date: Date.today,
  end_date: Date.today+3
}
]

cruises.each do |cruise|
  cruisy = Cruise.new(cruise)
  p cruisy
  # cruisy.stops.new(location: Location.by_random.first, start_location: true)

  # cruisy.stops.new(location: Location.first, start_location: true)
  # cruisy.stops.new(location: Location.last)
  # cruisy.stops.new(location: Location.first, end_location: true)

  qt = (2..5).to_a.sample
  Location.by_random.first(qt).each do |loc|
    cruisy.stops.new(location: loc)
  end
  # cruisy.stops.first.start_location = true
  # cruisy.stops.last.start_location = true
  # cruisy.stops.new(location: Location.by_random.first, end_location: true)
  cruisy.boat = Boat.by_random.first

  port = cruisy.stops.first.location.name
  names = ["#{port} - Sardinia - Baleares Islands",
  "#{port} to Sardinia",
  "Nice trip all around #{port}",
  "Sailing to #{port}, le Corazon des baléares",
  "Ciao #{port}",
  "#{port} le berceau de la Fiesta"]

  cruisy.update(name: names.sample)
  rand(5).times do
    @review = Review.new(
      cruise: cruisy,
      user: User.by_random.first,
      content: Faker::Restaurant.review,
      rating: rand(5)
    )
    @review.save
  end
  cruisy.valid?
  cruisy.routing
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

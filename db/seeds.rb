require 'open-uri'
require 'nokogiri'
require 'faker'
require "yaml"

puts "Destroying all instances"
Cruise.destroy_all
Boat.destroy_all
Booking.destroy_all
Review.destroy_all
Message.destroy_all



puts "done destroying"

boats = [{
  name: "Cash à l'eau",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/0lly6fazbt45f0pmeav1ysmoq36dexvv.big.jpg.gz",
  category: "Sun Odissey 349",
  capacity: 6,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Ode mer",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/7k56w3ksiells2bia9fp75q0wlym1w64.big.jpg.gz",
  category: "Lagoon 420",
  capacity: 8,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Patpau",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/18hjmkt8vm6kdnyvsrf8zwh5gnwi12ax.big.jpg.gz",
  category: "Bahia 46",
  capacity: 8,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Lashepriz",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/k1hi4mveo5i36s49i666gwb0e1uthpnf.big.jpg.gz",
  category: "Feeling 32",
  capacity: 4,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Nages et tais toi",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/lfp29o37ywzht0zp6xq2flhfe6blf6hr.big.jpg.gz",
  category: "Dufour 45 Performance",
  capacity: 8,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Almaco IV",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/ol31joo5zngi85kp9kpl5jx3aubbgata.big.jpg.gz",
  category: "Laboe 51",
  capacity: 6,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Croque le vent",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/te2yJvd38oNcvPy53Bh5dxpQP6VsTR1d.big.jpg.gz",
  category: "Sense 55",
  capacity: 8,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Altaîr",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/1pd04n9y42m0k0mq9h2rcvvew9lmgfy8.big.jpg.gz",
  category: "Bali 4.1",
  capacity: 8,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Mangareva",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/0gZs8iCPiz5gPymwqDjlYZs9gfaqODGW.big.jpg.gz",
  category: "Fontaine Pajot 40 Lucia",
  capacity: 4,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
},
{
  name: "Vaîmiti",
  description: Faker::Lorem.paragraph,
  photo: "https://static1.clickandboat.com/v1/p/5ie0mx2juawys96g0dzl898hbgnuo6p9.big.jpg.gz",
  category: "Sun-Fast 39",
  capacity: 6,
  activity: ["scuba diving", "paddle", "Canoe", "water skiing"].sample,
  user_id: 1
}
]



boats.each do |boat|
  boaty = Boat.new(boat)
  p boaty
  boaty.valid?
  boaty.save!
  # boaty.photos.attach(boaty.photo)
end

# html_doc.css('div.envItem').each do |a|

#   url_design = "https://www.clickandboat.com#{a.attribute('href')}"
#   html_file_design = open(url_design).read
#   html_doc_design = Nokogiri::HTML(html_file_design)

  # image_url = html_doc_voilier.at('.card-img img').attribute('src').value

  # name = {"Cash à l'eau", "Ode mer", "Patpau", "Lashepriz", "Nages et tais toi", "Almaco IV", "Croque le vent", "Altaîr", "Mangareva", "Vaîmiti"].sample

  # description = loremipsum30.text

  # category = ["monocoque", "catamaran"].sample

  # activity = ["scuba diving", "paddle", "Canoe", "water skiing"].sample

  # capacity = [4, 6, 8].sample

  # price = rand(10..40)

  # first_name = Faker::Name.first_name
  # last_name = Faker::Name.last_name
  # email = Faker::Internet.email
  # password = "123456"

  # user = User.create!(first_name: first_name, last_name: last_name, email: email, password: password)

  # user_photo_url = "https://thispersondoesnotexist.com/image"
  # user_photo_file = URI.open(user_photo_url)
  # user.photo.attach(io: user_photo_file, filename: "user_photo")

  # file = URI.open(image_url)

# end

puts "#{User.all.length} users created"
puts "#{Boat.all.length} boats created"


# board image to do after cloudinary setup
# image_url = html_doc.at('.image-inset img').attribute('src').value


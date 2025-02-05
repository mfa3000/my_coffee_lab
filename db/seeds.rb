# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'


puts "clears exiting data"
# Clear existing data (optional)
BeanCommentVote.destroy_all
RoasteryCommentVote.destroy_all
BeanReview.destroy_all
FavouriteBean.destroy_all
RoasteryReview.destroy_all
FavouriteRoastery.destroy_all
BeanComment.destroy_all
RoasteryComment.destroy_all
Location.destroy_all
Bean.destroy_all
Roastery.destroy_all
User.destroy_all



puts "creating fake data for users"
# Create fake users
users = []
10.times do
  users << User.create!(
    user_name: Faker::Internet.username,
    email: Faker::Internet.unique.email,
    password: "password",
  )
end
puts "fake users created"

puts "creating fake data for roasteries"
roasteries_data = [
  { name: "Kreuzberg Kaffeerösterei", address: "Skalitzer Str. 46, 10997 Berlin", description: "Nestled in the heart of Kreuzberg, this roastery specializes in bold, ethically sourced beans. Their small-batch roasting technique ensures rich flavors, from nutty Brazilian to bright Ethiopian blends.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712506/9_wdnnkt.png" },

  { name: "The Bean Collective", address: "Weserstr. 58, 12045 Berlin", description: "A community-driven roastery, The Bean Collective is all about sustainability and transparency. They work directly with farmers to bring out the best in each region’s beans.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712509/4_asjf7n.png" },

  { name: "Moabit Micro Roasters", address: "Alt-Moabit 78, 10555 Berlin", description: "This micro-roastery in Moabit is dedicated to slow roasting for maximum flavor.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712509/12_yqpozc.png" },

  { name: "Good Coffee", address: "Boxhagener Str. 20, 10245 Berlin", description: "A hub for coffee science lovers, Good Coffee experiments with different roast profiles to bring out unexpected flavors.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712509/10_tu84pg.png" },

  { name: "Espresso Works", address: "Rosenthaler Str. 63, 10119 Berlin", description: "Inspired by Italian espresso culture but with a modern twist, Espresso Works focuses on well-balanced, low-acidity espresso blends.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712509/11_aq3und.png" },

  { name: "Charlottenburg Craft Coffee", address: "Kantstr. 142, 10623 Berlin", description: "This boutique roastery in West Berlin handcrafts their coffee in small batches, bringing out sweet, nutty, and citrusy notes.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712510/8_rfx0fh.png" },

  { name: "Berg Roasters", address: "Schönhauser Allee 123, 10437 Berlin", description: "Known for their light roasts and Nordic-style coffee, (Prenzlauer) Berg Roasters bring out bright, fruity, and floral characteristics.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712510/6_gmchjl.png" },

  { name: "Heritage Coffee", address: "Manfred-von-Richthofen-Str. 17, 12101 Berlin", description: "Blending tradition with innovation, Heritage Coffee specializes in classic European-style blends with a modern edge.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712512/2_gowk9a.png" },

  { name: "The Coffee Syndicate", address: "Müllerstr. 151, 13353 Berlin", description: "This urban roastery thrives on collaboration, partnering with Berlin’s best cafés to create custom blends.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712515/5_unx7b3.png" },

  { name: "Slow Roasters", address: "Falkenseer Chaussee 23, 13581 Berlin", description: "Committed to the art of slow roasting, this family-run roastery in Spandau takes a meticulous approach to bringing out deep caramel, nut, and chocolate notes.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712516/7_qyzvyn.png" },

  { name: "Artisan Beans", address: "Elsenstr. 78, 12435 Berlin", description: "A hidden gem near the Spree, Artisan Beans sources organic, fair-trade beans and roasts them in small batches for optimal flavor.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712516/3_dlhaml.png" },

  { name: "Brew Masters", address: "Hauptstr. 94, 10827 Berlin", description: "Focusing on innovative roasting techniques, Brew Masters craft their beans to highlight sweetness and complexity.", image_url: "https://res.cloudinary.com/dtqchggeh/image/upload/v1738712512/1_svzpkd.png" }
]

roasteries = []
roasteries_data.each_with_index do |data, index|
  roastery = Roastery.create!(
    name: data[:name],
    description: data[:description],
    image: data[:image_url],
    roastery_url: "https://#{data[:name].parameterize}.com",
    user: users.sample
  )

  file = URI.open(data[:image_url])
  roastery.main_photo.attach(io: file, filename: "roastery_#{index + 1}.png", content_type: "image/png")

  roasteries << roastery
end

puts "Fake roastery data created"

puts "Creating fake locations"
location_types = ["Cafe", "Roastery and Cafe", "Warehouse"]

roasteries.each_with_index do |roastery, index|
  Location.create!(
    address: roasteries_data[index][:address],
    location_type: location_types[index % location_types.length],
    roastery: roastery
  )
end
puts "Fake locations created"

puts "creating fake data for beans"

bean_data = [
  { name: "Ethiopian Sunrise", description: "A bright, floral Ethiopian Yirgacheffe with delicate jasmine and citrus notes, perfect for a refreshing morning brew.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738749559/pexels-qui-nguyen-7862521-19097139_z3kpkt.png" },

  { name: "Colombian Gold", description: "Smooth and balanced, this Colombian Supremo offers hints of caramel, red berries, and a lingering chocolatey finish.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747988/bean_12_wmzvwz.png" },

  { name: "Brazilian Dusk", description: "A smooth, nutty Brazilian coffee with notes of toasted almonds, milk chocolate, and a hint of caramel.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747987/bean_8_kqmndl.png" },

  { name: "Velvet Espresso", description: "A rich and creamy espresso blend with notes of dark chocolate, roasted almonds, and caramelized sugar.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747985/bean_6_yqu7xv.png" },

  { name: "Sumatran Spice", description: "A deep, earthy Sumatran blend with spicy undertones and hints of dark chocolate, perfect for espresso lovers.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747985/bean_11_xjq2vr.png" },

  { name: "Kenyan Peaberry", description: "Bright and juicy with a wine-like acidity, this Kenyan Peaberry features blackberry, plum, and citrus flavors.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747984/bean_3_bqauye.png" },

  { name: "Honey Process Reserve", description: "Grown using the honey processing method, this coffee boasts natural sweetness with caramel and stone fruit undertones.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747984/bean_5_sogiwp.png" },

  { name: "Antigua Dark Roast", description: "A well-balanced Guatemalan coffee with a chocolatey body, bright acidity, and subtle nutty flavors.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747983/bean_7_dhp0yg.png" },

  { name: "Honduran Harmony", description: "Smooth and well-rounded, this Honduran coffee features notes of almonds, brown sugar, and gentle citrus.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747983/bean_10_pwagqk.png" },

  { name: "Vietnamese Lotus", description: "A bold, full-bodied Vietnamese Robusta with intense chocolatey notes, low acidity, and a strong finish.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747981/bean_9_qchghb.png" },

  { name: "Geisha Reserve", description: "One of the most prized coffees in the world, this Geisha variety delivers exceptional floral aromas, vibrant acidity, and a tea-like body.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747978/bean_2_nsjbfu.png" },

  { name: "Mountain Chiapas", description: "This organic Mexican coffee showcases bright acidity, milk chocolate sweetness, and hints of roasted nuts.", image_url:"https://res.cloudinary.com/dtqchggeh/image/upload/v1738747977/bean_1_vuykht.png" }

  # { name: "Andean Breeze", description: "A mild and smooth Peruvian coffee with caramel sweetness, citrus notes, and a clean finish.", image_url:"" },

  # { name: "Monsoon Malabar Bold", description: "Uniquely processed, this Indian coffee has a bold, spicy character with low acidity and a syrupy mouthfeel.", image_url:"" },

  # { name: "Red Bourbon Selection", description: "A complex Rwandan coffee with red fruit notes, floral aromas, and a silky body.", image_url:"" },

  # { name: "Spiced Mocha", description: "A rare and ancient Yemeni coffee with winey acidity, deep chocolate notes, and hints of exotic spices.", image_url:"" }
]

brewing_method = ["espresso", "filter"]
roast_level = ["dark", "medium", "light"]
origins = ["Ethiopia", "Colombia", "Brazil", "Vietnam"]
flavours = ["Fruity", "Nutty", "Chocolatey", "Floral", "Spicy"]
beans = []

bean_data.each_with_index do |data, index|

  bean = Bean.create!(
    name: data[:name],
    description: data[:description],
    brewing_method: brewing_method.sample,
    roast_level: roast_level.sample,
    origin: origins.sample,
    flavour: flavours.sample,
    roastery: roasteries.sample,
    user: users.sample,
  )

  file = URI.open(data[:image_url])
  bean.main_photo.attach(io: file, filename: "bean_#{index + 1}.png", content_type: "image/png")

  beans << bean
end

puts "fake beans created"

puts "creating fake data for bean comments"
bean_comments = []
50.times do
  bean_comments << BeanComment.create!(
    comment: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    user: users.sample,
    bean: beans.sample,
  )
end

puts "fake bean comments created"

puts "creating fake data for roastery comments"
roastery_comments = []
50.times do
  roastery_comments << RoasteryComment.create!(
    comment: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    user: users.sample,
    roastery: roasteries.sample,
  )
end

puts "fake roastery comments created"

puts "creating fake data for bean comment votes"

200.times do
  user = users.sample
  bean_comment = bean_comments.sample

  unless BeanCommentVote.exists?(user: user, bean_comment: bean_comment)
  BeanCommentVote.create!(
    vote: [true, false].sample,
    bean_comment: bean_comment,
    user: user,
  )
  end
end

puts "fake bean comment votes created"

puts "creating fake data for roastery comment votes"

200.times do
  user = users.sample
  roastery_comment = roastery_comments.sample

  unless RoasteryCommentVote.exists?(user: user, roastery_comment: roastery_comment)
  RoasteryCommentVote.create!(
    vote: [true, false].sample,
    roastery_comment: roastery_comment,
    user: user,
  )
  end
end

puts "fake roastery comment votes created"

puts "creating fake data for bean reviews"

200.times do
  bean = beans.sample
  user = users.sample

  unless BeanReview.exists?(bean: bean, user: user)
    BeanReview.create!(
      rating: rand(1..5),
      bean: bean,
      user: user,
    )
  end
end

puts "fake bean reviews created"

puts "creating fake data for roastery reviews"

200.times do
  roastery = roasteries.sample
  user = users.sample

  # Check if the user already reviewed this bean
  unless RoasteryReview.exists?(roastery: roastery, user: user)
    RoasteryReview.create!(
      rating: rand(1..5),
      roastery: roastery,
      user: user,
    )
  end
end

puts "fake roastery reviews created"

puts "creating fake data for favourite beans"

50.times do
  bean = beans.sample
  user = users.sample

  unless FavouriteBean.exists?(bean: bean, user: user)
  FavouriteBean.create!(
    bean: bean,
    user: user,
  )
  end
end

puts "fake favourite beans created"

puts "creating fake data for favourite roasteries"

50.times do
  roastery = roasteries.sample
  user = users.sample

  unless FavouriteRoastery.exists?(roastery: roastery, user: user)
  FavouriteRoastery.create!(
    roastery: roastery,
    user: user
  )
  end
end

puts "fake favourite roasteries created"

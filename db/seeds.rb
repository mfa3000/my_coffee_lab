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
roasteries = []
picture_id = 0
16.times do

  roasteries << Roastery.create!(
    name: "#{Faker::Restaurant.name} Roastery",
    description: Faker::Restaurant.description,
    image: "https://picsum.photos/id/#{200+picture_id}/320/240",
    roastery_url: "https://www.lewagon.com/",
    user: users.sample,
  )
  picture_id += 1
end
puts "fake roasteries created"

puts "creating fake data for beans"

brewing_method = ["espresso", "filter"]
roast_level = ["dark", "medium", "light"]
origins = ["Ethiopia", "Colombia", "Brazil", "Vietnam"]
flavours = ["Fruity", "Nutty", "Chocolatey", "Floral", "Spicy"]
picture_id = 0
beans = []

16.times do
  beans << Bean.create!(
    name: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    image: "https://picsum.photos/id/#{100+picture_id}/320/240",
    brewing_method: brewing_method.sample,
    roast_level: roast_level.sample,
    origin: origins.sample,         
    flavour: flavours.sample,
    roastery: roasteries.sample,
    user: users.sample,
  )
  picture_id += 1
end

puts "fake beans created"


puts "creating fake data for locations"
location_type = ["Cafe", "Roastery and Cafe", "Warehouse"]

16.times do
  Location.create!(
    address: Faker::Address.full_address,
    location_type: location_type.sample,
    roastery: roasteries.sample,
  )
end

puts "fake locations created"

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
  BeanCommentVote.create!(
    vote: [true, false].sample,
    bean_comment: bean_comments.sample,
    user: users.sample,
  )
end

puts "fake bean comment votes created"

puts "creating fake data for roastery comment votes"

200.times do
  RoasteryCommentVote.create!(
    vote: [true, false].sample,
    roastery_comment: roastery_comments.sample,
    user: users.sample,
  )
end

puts "fake roastery comment votes created"

puts "creating fake data for bean reviews"

200.times do
  BeanReview.create!(
    rating: rand(1..5),
    bean: beans.sample,
    user: users.sample,
  )
end

puts "fake bean reviews created"

puts "creating fake data for roastery reviews"

200.times do
  RoasteryReview.create!(
    rating: rand(1..5),
    roastery: roasteries.sample,
    user: users.sample,
  )
end

puts "fake roastery reviews created"

puts "creating fake data for favourite beans"

50.times do
  FavouriteBean.create!(
    bean: beans.sample,
    user: users.sample,
  )
end

puts "fake favourite beans created"

puts "creating fake data for favourite roasteries"

50.times do
  FavouriteRoastery.create!(
    roastery: roasteries.sample,
    user: users.sample,
  )
end

puts "fake favourite roasteries created"

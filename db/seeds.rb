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
Location.destroy_all
Bean.destroy_all
Roastery.destroy_all
User.destroy_all



puts "creating fake data for users"
# Create fake users
users = []
2.times do
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
picture_id = 0
16.times do

  Bean.create!(
    name: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    image: "https://picsum.photos/id/#{100+picture_id}/320/240",
    brewing_method: brewing_method.sample,
    roast_level: roast_level.sample,
    roastery: roasteries.sample,
    user: users.sample,
  )
  picture_id += 1
end

puts "fake beans created"


puts "creating fake data for locations"
location_category = ["Cafe", "Roastery and Cafe", "Warehouse"]

16.times do
  Location.create!(
    address: Faker::Address.full_address,
    type: location_category.sample,
    roastery: roasteries.sample,
  )
end

puts "fake locations created"

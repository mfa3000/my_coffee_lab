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
require 'fake-picture'

puts "clears exiting data"
# Clear existing data (optional)
User.destroy_all
Roastery.destroy_all
Beans.destroy_all


puts "creating fake data for users"
# Create fake users
users = []
2.times do
  users << User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "password"
  )
end
puts "fake users created"

puts "creating fake data for Roasteries"
# Create fake cooking classes
categories = ["Mexican", "Japanese", "Italian", "Thai", "Street Food", "Indian", "French", "Other"]

16.times do

  Roastery.create(
    name: "#{Faker::Restaurant.name} Roastery",
    description: Faker::Restaurant.description,
    image: FakePicture::Company.logo
    roastery_url: "https://www.lewagon.com/",
    user: users.sample
  )
end

16.times do

  Bean.create(
    name: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    image: FakePicture::Company.logo
    roastery_url: "https://www.lewagon.com/",
    user: users.sample
  )
end


puts "fake cooking class created"

# Faker::Coffee.blend_name #=> "Summer Solstice"

# Faker::Coffee.origin #=> "Antigua, Guatemala"

# Faker::Coffee.variety #=> "Pacas"

# Faker::Coffee.notes #=> "balanced, silky, marzipan, orange-creamsicle, bergamot"

# Faker::Coffee.intensifier #=> "quick"

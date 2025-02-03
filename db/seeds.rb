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
roastery_image_urls = [
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738598119/Screenshot_2025-02-03_at_16.54.13_qkcsoi.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738598118/Screenshot_2025-02-03_at_16.54.22_qbc5im.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738598117/Screenshot_2025-02-03_at_16.54.35_udpwxd.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738598117/Screenshot_2025-02-03_at_16.54.42_su7ixd.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738598116/Screenshot_2025-02-03_at_16.54.54_uvk535.png"
]
roasteries = []
picture_id = 0
16.times do
  image_url = roastery_image_urls.sample

  roastery = Roastery.create!(
    name: "#{Faker::Restaurant.name} Roastery",
    description: Faker::Restaurant.description,
    image: "https://picsum.photos/id/#{200+picture_id}/320/240",
    roastery_url: "https://www.lewagon.com/",
    user: users.sample,
  )
  file = URI.open(image_url)
  roastery.main_photo.attach(io: file, filename: "roastery_photo_#{picture_id}.png", content_type: "image/png")

  roasteries << roastery
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

bean_image_urls = [
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738596076/Screenshot_2025-02-03_at_16.19.35_ke4yjx.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738596074/Screenshot_2025-02-03_at_16.20.37_fyhizd.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738596073/Screenshot_2025-02-03_at_16.19.49_qpcllo.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738596073/Screenshot_2025-02-03_at_16.20.13_bdlz82.png",
  "https://res.cloudinary.com/dtqchggeh/image/upload/v1738596072/Screenshot_2025-02-03_at_16.20.54_zawhld.png",
]

16.times do
  image_url = bean_image_urls.sample

  bean = Bean.create!(
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

  file = URI.open(image_url)
  bean.main_photo.attach(io: file, filename: "bean#{picture_id}.png", content_type: "image/png")

  beans << bean
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

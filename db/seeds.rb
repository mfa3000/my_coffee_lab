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
    address: data[:address],
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
bean_comments_texts = [
  "Super clean acidity—bright, citrusy, and great as a pour-over.",
  "Rich chocolate and caramel notes—perfect for espresso lovers!",
  "Smooth and nutty with a touch of spice—amazing as a French press!",
  "This bean has incredible sweetness—almost like honey in your cup.",
  "Vibrant and juicy—this coffee is a berry bomb!",
  "Great crema and deep chocolate notes—fantastic for lattes!",
  "Tried this natural fruity bean—it’s like drinking blueberries!",
  "Incredibly smooth mouthfeel—so silky and balanced!",
  "Bright acidity and tea-like body—reminds me of a light white wine.",
  "One of the best Guatemalan coffees I’ve had—chocolatey and rich!",
  "Tried this washed Ethiopian on a Chemex, and it was incredibly clean—floral aromas, citrusy acidity, and a delicate tea-like body with a honeyed finish.",
  "Pulled a shot of this bean on my espresso machine—balanced caramel sweetness, medium body, and a lingering nutty finish. No need for sugar at all!",
  "This natural-processed Brazilian coffee had a syrupy mouthfeel and deep chocolatey notes. Brewed it as a cold brew, and it was smooth and refreshing!",
  "The anaerobic fermentation on this coffee gives it an intense tropical fruit punch flavor—it’s like mango, pineapple, and a hint of red wine all in one cup.",
  "Brewed this Sumatran as a French press, and it was so bold and earthy. Deep notes of dark chocolate, spice, and a velvety finish made it perfect for slow sipping.",
  "This bean is one of the brightest coffees I’ve ever tasted—huge berry notes, crisp acidity, and a red wine-like mouthfeel. Would recommend for adventurous drinkers!",
  "Tried this washed Guatemalan as a flat white, and it held up beautifully in milk. Nutty sweetness with hints of brown sugar and a smooth, buttery finish.",
  "Had my first honey-processed bean, and wow—the caramelization makes it incredibly sweet and complex. Brewed it in an AeroPress, and it was like liquid gold!",
  "Dialed in this Ethiopian for espresso, and it was stunning—juicy acidity, bright floral notes, and a lingering peach sweetness that made every sip exciting.",
  "This micro-lot Panama Geisha is something special—floral aromatics, silky texture, and an aftertaste that lingers like jasmine tea. Worth every penny!",
  "This washed Ethiopian has delicate floral notes and crisp acidity—makes a fantastic morning pour-over.",
  "A beautifully balanced Colombian coffee with caramel sweetness, juicy red fruit, and a chocolate finish.",
  "This Sumatran coffee is bold and earthy with deep spice notes—perfect for those who love strong, full-bodied brews.",
  "Incredibly smooth and nutty with hints of hazelnut and brown sugar—great for an everyday espresso.",
  "I get notes of citrus, honey, and a tea-like body—this Kenyan Peaberry is truly unique!",
  "The natural processing really shines here—deep berry flavors, syrupy body, and a sweet lingering finish.",
  "One of the cleanest coffees I’ve had—bright, crisp, and floral with a juicy mouthfeel.",
  "Brewed this in my AeroPress, and it was bursting with caramel and dried fruit flavors!",
  "Perfectly balanced acidity and body—makes a super versatile coffee for different brew methods.",
  "This dark roast is bold but smooth, with chocolate and molasses notes—great for lattes!",
  "The fruit-forward profile of this Ethiopian coffee is stunning—tastes like blueberries and jasmine.",
  "Love the wine-like acidity in this one—it’s juicy and complex with a long, sweet finish.",
  "A comforting, well-rounded coffee with milk chocolate sweetness and a nutty undertone.",
  "Tried this as an espresso shot—so smooth, rich, and naturally sweet with a thick crema."
]

bean_comments = []
bean_comments_texts.each do |comment_text|
  bean_comments << BeanComment.create!(
    comment: comment_text,
    user: users.sample,
    bean: beans.sample
  )
end

puts "fake bean comments created"

puts "creating fake data for roastery comments"
puts "Assigning fixed roastery comments..."
roastery_comments_texts = [
  "Their washed Ethiopian is bright, clean, and citrusy—a fantastic pour-over!",
  "Their honey-processed Costa Rican is syrupy, sweet, and full-bodied.",
  "You can taste the caramelization in their beans—so much natural sweetness!",
  "Their Kenyan espresso has such juicy acidity and a wine-like finish.",
  "A true coffee nerd’s paradise—great beans, great roasting, and great people!",
  "They roast light, letting the beans’ natural flavors shine—love their approach!",
  "Tried their Sumatran dark roast—earthy, spicy, and incredibly bold.",
  "Love their experimental roasting techniques—always something new to discover!",
  "The natural Ethiopian here is wild—tastes like blueberries and jasmine!",
  "Their baristas are dialed in—every espresso shot is smooth, sweet, and balanced.",
  "Tried their natural-processed Ethiopian on a V60, and the fruit notes exploded—tasted like blueberry jam with a tea-like finish. The clarity was next level!",
  "Had an amazing chat with their head roaster about fermentation processing. Their anaerobic Colombian was funky, boozy, and super complex—never had anything like it!",
  "Love that they offer cupping sessions! I was able to taste the differences between washed and natural processing side by side—it completely changed how I think about coffee.",
  "This roastery sources beans with insane attention to detail. Their micro-lot Honduran coffee had such refined caramel and nutty flavors with a lingering sweetness.",
  "I had a cortado with their single-origin El Salvadoran, and even in milk, the flavor shined. Super balanced with a creamy mouthfeel and sweet, nutty undertones.",
  "Their Geisha variety is unreal. Brewed it as a Chemex and got jasmine, mango, and a delicate honey sweetness—it felt more like tea than coffee in the best way!",
  "Was blown away by their aged Sumatra—it had deep spice, earthy notes, and a full-bodied mouthfeel. Perfect for those who love intense, bold coffee!",
  "If you’re into ultra-light roasts, this is the place. Their washed Kenyan is incredibly bright, with grapefruit acidity and a long, tea-like finish.",
  "One of the few roasteries that truly understands espresso. Their medium roast Guatemalan creates a rich, chocolatey shot with balanced acidity and zero bitterness.",
  "What sets them apart is their transparency—every bag of beans comes with origin details, altitude, processing method, and even tasting notes for optimal brewing.",
  "Had a fascinating conversation with the roaster about their honey-processed beans—sweet, syrupy, and full-bodied.",
  "Their espresso roast is well-balanced, no overpowering bitterness, just a smooth mix of chocolate, nuts, and a touch of fruit.",
  "I love that they experiment with different roast profiles—tried their latest light roast, and it had the perfect tea-like body.",
  "Their approach to slow roasting really brings out the caramelization in their beans—so much sweetness without over-roasting.",
  "The Kenyan single origin here bursts with blackcurrant and grapefruit acidity—one of the best I’ve had.",
  "I was blown away by their anaerobic fermentation coffee—super complex with funky tropical fruit notes.",
  "They focus on Nordic-style roasting, meaning you get ultra-bright, juicy cups with a delicate body—perfect for pour-overs.",
  "Tried their new natural-processed Brazilian—so much body and a lingering chocolatey sweetness that holds up well in milk.",
  "They source some of the rarest micro-lots, and their Panama Geisha is on another level—floral, tea-like, and super aromatic.",
  "Their roasting consistency is impressive—every batch of their Colombian beans maintains that perfect balance of acidity and sweetness.",
  "I love how they highlight terroir in their coffees—you can really taste the difference between their Ethiopian and Kenyan beans.",
  "Their honey-processed Costa Rican coffee is exceptional—notes of dried fruit, caramel, and a rich, syrupy mouthfeel.",
  "Not only do they roast great coffee, but their baristas really understand extraction—my V60 had perfect clarity and sweetness.",
  "I always appreciate a roastery that provides detailed brew guides for their beans—makes dialing in espresso so much easier!",
  "You can tell their beans are roasted with care—no burned notes, just clean, well-developed flavors that shine through.",
  "Their washed Yirgacheffe has such a delicate floral aroma—brewing it as a Chemex really enhances its clarity.",
  "Really love how they highlight small producers—each coffee tells a story about the farm and its processing method.",
  "Had a shot of their single-origin espresso—bright, juicy, and so well-balanced that I didn’t even need sugar or milk.",
  "Great to see a roastery focusing on sustainable and direct trade relationships—the quality really speaks for itself.",
  "The depth of their Sumatran dark roast is incredible—spicy, earthy, and with a rich, velvety body.",
  "Tried their espresso flight—amazing how different roast levels and origins completely change the flavor profile."
]

roastery_comments = []

roastery_comments_texts.each do |comment_text|
  roastery_comments << RoasteryComment.create!(
    comment: comment_text,
    user: users.sample,
    roastery: roasteries.sample
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

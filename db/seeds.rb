# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users_names = %w{ RaulC Rafa Virgi Lara Lluis RaulV RaulP Charlie Gonzalo David Alvaro Fernando Ana Maca Christian Iago Giancarlo Yoli Isaura Laura }
user_password = "12345678"

pets_names = %w{ Lola Tapa Chusa Jenny Lalili Negrito Luna Tarzan Bruno Chess Bicho Piolin Fifi Silvestre Jerry Negra Blacky Copito Aquiles Sushi }
pets_images = [
  "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg",
  "http://s2.favim.com/orig/150426/animal-aww-blink-cat-Favim.com-2682792.gif",
  "https://www.petfinder.com/wp-content/uploads/2012/11/93394608-pets-welcome-policy-632x475.jpg",
  "http://www.petsworld.in/blog/wp-content/uploads/2014/12/happy.gif",
  "http://www.cutenessoverflow.com/wp-content/uploads/2014/07/dog-gifs-6.gif",
  "http://www.petango.com/sms/photos/1686/35d7bfd7-a95a-42eb-af9f-97654d130499.jpg",
  "http://www.petango.com/sms/photos/1686/5a30577d-4ea7-4497-8bde-a25484e1999f.jpg",
  "https://m.popkey.co/0dfddf/g3ozK.gif",
  "http://www.petango.com/sms/photos/1686/51269cd1-e229-44fd-bd79-e6a5ac54e759.jpg",
  "http://huffordfh.com/wp-content/uploads/2010/07/pets.jpg",
  "http://38.media.tumblr.com/97d7738842b86d9367988276c88eeafc/tumblr_inline_nrirgeNFFp1qjxfzm_500.gif",
  "http://static4.businessinsider.com/image/508840e96bb3f7f749000008/inside-the-bizarre-world-of-sexy-halloween-costumes--for-pets.jpg",
  "http://i.telegraph.co.uk/multimedia/archive/03341/slowloris2_3341756b.jpg",
  "http://49.media.tumblr.com/ebd6f63ad9bb802f2496e7823b649714/tumblr_nku3clqlEy1snq0sro2_500.gif",
  "https://media.giphy.com/media/y4Hl0rKWwVTpu/giphy.gif",
  "https://s-media-cache-ak0.pinimg.com/originals/b8/ee/4f/b8ee4fc75c808d5cc3f5912bc078f999.gif",
  "http://www.awesomelycute.com/gallery/2013/12/awesomelycute-com-2723.gif",
  "https://ak-hdl.buzzfed.com/static/enhanced/webdr03/2012/12/19/13/anigif_enhanced-buzz-15593-1355941359-4.gif",
  "http://cdn-media-1.lifehack.org/wp-content/files/2014/10/tumblr_meo8moUf1Q1rkh2rbo1_500.gif",
  "http://gifsec.com/wp-content/uploads/GIF/2015/12/A-pet-raven-GIF.gif"
]
pet_category = %w{ cat cat dog dog dog rodent reptile rodent reptile dog exotic dog exotic bird dog cat dog rodent dog bird }
pet_age_range = 1..15

(0..19).each do |index|
  user = User.create(name: users_names[index], email: "#{users_names[index].downcase}@gmail.com", password: user_password, password_confirmation: user_password)
  user.save
  user = User.last
  pet = user.pets.create(name: pets_names[index], animal: pet_category[index], age: rand(pet_age_range), image: pets_images[index])
  pet.save
end




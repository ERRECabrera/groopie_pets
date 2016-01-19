# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(name: "raul", email: "raul@gmail.com", password: "12345678", password_confirmation: "12345678")
user.save
user = User.first
user.pets.create(name: "lola", animal: "cat", age: 11, image: "https://media.licdn.com/mpr/mpr/shrinknp_800_800/AAEAAQAAAAAAAAYfAAAAJDg1MmIxYWQ1LTMwMDgtNDdjZC04MzZlLWVlYTUwZDQyNmUwOQ.jpg")

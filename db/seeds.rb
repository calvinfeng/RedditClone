# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.create!(email: "albert", password: 1234)
User.create!(email: "bob", password: 1234)
User.create!(email: "calvin", password: 1234)

Hub.create!(title: "Automobile",
            description: "Post your favorite ride here",
            author_id: 3)

Hub.create!(title: "Animal",
            description: "What do we know about life?",
            author_id: 3)

Hub.create!(title: "Kitty",
            description: "Cats are programmers' best friends",
            author_id: 3)

Hub.create!(title: "Pornhub",
            description: "What would be hub without porn?",
            author_id: 3)

30.times do
  Hub.create!(title: Faker::Book.title,
              description: Faker::Lorem.sentence,
              author_id: 3)
end

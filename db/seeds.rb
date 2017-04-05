# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
require 'faker'

# meetup_users_attributes = [
#   {meetup_id: 1, user_id: 2},
#   {meetup_id: 1, user_id: 3},
#   {meetup_id: 1, user_id: 4}
# ]

User.delete_all
3.times do
  new_user = {provider: "github", uid: Faker::Number.number(6), username: Faker::Pokemon.name, email: Faker::Internet.email, avatar_url: Faker::Avatar.image}
  User.create(new_user)
end


Meetup.delete_all
3.times do
  new_meetup = {owner_id: User.all.sample.id, name: Faker::Space.planet, description: Faker::Lorem.sentences(2), location: Faker::Space.galaxy}
  Meetup.create(new_meetup)
end

MeetupsUser.delete_all
5.times do
  meetup = Meetup.all.sample
  user_id = User.all.sample.id
  while meetup.owner_id == user_id
    user_id = User.all.sample.id
  end
  new_association = {user_id: user_id, meetup_id: meetup.id}
  MeetupsUser.create(new_association)
end

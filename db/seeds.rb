# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

user_attributes = [
  {provider: "github", uid: "12345", username: "test1", email: "test@gmail.com", avatar_url: "google.com"},
  {provider: "github", uid: "123456", username: "test2", email: "test2@gmail.com", avatar_url: "google.com"},
  {provider: "github", uid: "12346", username: "test3", email: "test3@gmail.com", avatar_url: "google.com"},
  {provider: "github", uid: "12347", username: "test4", email: "test4@gmail.com", avatar_url: "google.com"},
  {provider: "github", uid: "12348", username: "test5", email: "test5@gmail.com", avatar_url: "google.com"}
]

meetup_attributes = [
  {created_by: 2, created_by_uid: 123456, name: "test meetup", description: "desctiption test", location: "boston"},
  {created_by: 1, created_by_uid: 12345, name: "a test meetup", description: "desctiption test", location: "new york"},
  {created_by: 3, created_by_uid: 12346, name: "z test meetup", description: "desctiption test", location: "boston"},
  {created_by: 2, created_by_uid: 123456, name: "q test meetup", description: "desctiption test", location: "boston"}
]

# meetup_users_attributes = [
#   {meetup_id: 1, user_id: 2},
#   {meetup_id: 1, user_id: 3},
#   {meetup_id: 1, user_id: 4}
# ]

User.delete_all
user_attributes.each do |user_details|
  User.create(user_details)
end

Meetup.delete_all
meetup_attributes.each do |meetup_details|
  Meetup.create(meetup_details)
end

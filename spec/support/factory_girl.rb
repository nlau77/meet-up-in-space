require 'factory_girl'

FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "jarlax#{n}" }
    sequence(:email) { |n| "jarlax#{n}@launchacademy.com" }
    avatar_url "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
  end
end


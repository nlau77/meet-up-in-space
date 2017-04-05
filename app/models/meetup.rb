class Meetup < ActiveRecord::Base
  has_many :meetups_users
  has_many :users,
  through: :meetups_users
  belongs_to :owner, class_name: "User"

  validates :name, presence: true
  validates :name, length: { minimum: 1 }

  validates :description, presence: true
  validates :description, length: { minimum: 5, maximum: 1000 }

  validates :location, presence: true
  validates :location, length: { minimum: 1, maximum: 100 }

  validates :owner_id, presence: true
  validates :owner_id, numericality: true
end

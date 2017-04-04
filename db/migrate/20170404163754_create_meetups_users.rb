class CreateMeetupsUsers < ActiveRecord::Migration
  def change
    create_table :meetups_users do |table|
      table.belongs_to :meetup, index: true
      table.belongs_to :user, index: true

      table.timestamps null: false
    end
  end
end

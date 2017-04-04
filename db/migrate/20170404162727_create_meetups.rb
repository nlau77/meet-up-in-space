class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.integer :created_by, null: false
      table.integer :created_by_uid, null: false
      table.string :name, null: false
      table.text :description, null: false
      table.string :location, null: false

      table.timestamps null: false
    end
  end
end

class UpdateMeetupsUserIdColumn < ActiveRecord::Migration
  def change
    change_table :meetups do |table|
      table.remove :created_by_uid, :created_by
      table.belongs_to :owner, null: false
    end
  end
end

class UpdateOwnerColumnNameAndAssociation < ActiveRecord::Migration
  def change
    change_table :meetups do |table|
      table.remove :owner_id
      table.belongs_to :owner, null:false
    end
  end
end

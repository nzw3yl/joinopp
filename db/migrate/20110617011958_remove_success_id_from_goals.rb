class RemoveSuccessIdFromGoals < ActiveRecord::Migration
  def self.up
    remove_column :goals, :success_id
  end

  def self.down
    add_column :goals, :success_id, :integer
  end
end

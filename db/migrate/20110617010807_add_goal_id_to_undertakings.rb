class AddGoalIdToUndertakings < ActiveRecord::Migration
  def self.up
    add_column :undertakings, :goal_id, :integer
  end

  def self.down
    remove_column :undertakings, :goal_id
  end
end

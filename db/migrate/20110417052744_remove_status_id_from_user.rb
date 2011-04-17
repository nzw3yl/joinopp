class RemoveStatusIdFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :status_id
  end

  def self.down
    add_column :users, :status_id, :integer
  end
end

class AddStatusIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :status_id, :string
  end

  def self.down
    remove_column :users, :status_id
  end
end

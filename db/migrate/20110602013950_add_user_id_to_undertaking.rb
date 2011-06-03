class AddUserIdToUndertaking < ActiveRecord::Migration
  def self.up
    add_column :undertakings, :user_id, :integer
  end

  def self.down
    remove_column :undertakings, :user_id
  end
end

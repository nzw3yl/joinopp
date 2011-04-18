class DropTableRole < ActiveRecord::Migration
  def self.up
    drop_table :roles
  end

  def self.down
  end
end

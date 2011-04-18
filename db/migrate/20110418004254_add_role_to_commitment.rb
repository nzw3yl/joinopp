class AddRoleToCommitment < ActiveRecord::Migration
  def self.up
    add_column :commitments, :role, :string
  end

  def self.down
    remove_column :commitments, :role
  end
end

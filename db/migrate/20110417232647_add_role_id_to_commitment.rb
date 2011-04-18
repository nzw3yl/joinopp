class AddRoleIdToCommitment < ActiveRecord::Migration
  def self.up
    add_column :commitments, :role_id, :integer
  end

  def self.down
    remove_column :commitments, :role_id
  end
end

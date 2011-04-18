class RemoveColumnRoleIdFromCommitment < ActiveRecord::Migration
  def self.up
    remove_column :commitments, :role_id
  end

  def self.down
    add_column :commitments, :role_id, :integer
  end
end

class AddRolesMaskToCommitment < ActiveRecord::Migration
  def self.up
    add_column :commitments, :roles_mask, :integer
  end

  def self.down
    remove_column :commitments, :roles_mask
  end
end

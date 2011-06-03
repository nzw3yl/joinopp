class AddScopeMaskToUndertaking < ActiveRecord::Migration
  def self.up
    add_column :undertakings, :scope_mask, :integer
  end

  def self.down
    remove_column :undertakings, :scope_mask
  end
end

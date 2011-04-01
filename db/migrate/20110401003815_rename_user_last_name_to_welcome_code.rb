class RenameUserLastNameToWelcomeCode < ActiveRecord::Migration
  def self.up
	rename_column :users, :first_name, :welcome_code
        rename_column :users, :last_name, :name
  end

  def self.down
	rename_column :users, :name, :last_name
	rename_column :users, :welcome_code, :first_name
  end
end

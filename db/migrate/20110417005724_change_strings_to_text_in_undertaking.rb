class ChangeStringsToTextInUndertaking < ActiveRecord::Migration
  def self.up
    change_column :undertakings, :title, :text
    change_column :undertakings, :description, :text
    change_column :undertakings, :success_if, :text
  end

  def self.down
    change_column :undertakings, :title, :string
    change_column :undertakings, :description, :string
    change_column :undertakings, :success_if, :string
  end
end

class ChangeTitleToStringInUndertaking < ActiveRecord::Migration
  def self.up
     change_column :undertakings, :title, :string
  end

  def self.down
     change_column :undertakings, :title, :text
  end
end

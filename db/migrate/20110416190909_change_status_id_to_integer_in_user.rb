class ChangeStatusIdToIntegerInUser < ActiveRecord::Migration
  def self.up
     change_column :users, :status_id, :integer
  end

  def self.down
     change_column :users, :status_id, :string
  end
end

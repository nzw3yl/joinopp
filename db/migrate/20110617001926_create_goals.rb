class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.string :title
      t.string :description
      t.integer :success_id
      t.integer :user_id
      t.integer :scope_mask

      t.timestamps
    end
    add_index :goals, :user_id
  end

  def self.down
    drop_table :goals
  end
end

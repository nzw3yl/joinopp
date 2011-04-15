class CreateCommitments < ActiveRecord::Migration
  def self.up
    create_table :commitments do |t|
      t.integer :user_id
      t.integer :undertaking_id

      t.timestamps
    end
    add_index :commitments, :user_id
    add_index :commitments, :undertaking_id
    add_index :commitments, [:user_id, :undertaking_id], :unique => true
  end

  def self.down
    drop_table :commitments
  end
end

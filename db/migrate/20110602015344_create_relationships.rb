class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :contributor_id
      t.integer :contributed_id

      t.timestamps
    end
    add_index :relationships, :contributor_id
    add_index :relationships, :contributed_id
    add_index :relationships, [:contributor_id, :contributed_id], :unique => true
  end

  def self.down
    drop_table :relationships
  end
end

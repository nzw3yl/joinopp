class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :email
      t.string :access_code
      t.datetime :expiry
      t.integer :undertaking_id
      t.integer :invitee_id
      t.integer :inviter_id

      t.timestamps
    end
    add_index :invitations, :access_code
    add_index :invitations, :email
    add_index :invitations, [:email, :access_code]
  end

  def self.down
    drop_table :invitations
  end
end

class CreateUndertakings < ActiveRecord::Migration
  def self.up
    create_table :undertakings do |t|
      t.string :title
      t.string :description
      t.integer :status_id
      t.string :success_if
      t.integer :visibility_id
      t.string :access_code

      t.timestamps
    end
  end

  def self.down
    drop_table :undertakings
  end
end

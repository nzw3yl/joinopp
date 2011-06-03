class AddMetricIdToUndertaking < ActiveRecord::Migration
  def self.up
    add_column :undertakings, :metric_id, :integer
  end

  def self.down
    remove_column :undertakings, :metric_id
  end
end

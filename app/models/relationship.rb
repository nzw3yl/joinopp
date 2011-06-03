# == Schema Information
# Schema version: 20110602015344
#
# Table name: relationships
#
#  id             :integer         not null, primary key
#  contributor_id :integer
#  contributed_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Relationship < ActiveRecord::Base
  attr_accessible :contributed_id

  belongs_to :contributor, :class_name => "Undertaking"
  belongs_to :contributed, :class_name => "Undertaking"

  validates :contributor_id, :presence => true
  validates :contributed_id, :presence => true
end

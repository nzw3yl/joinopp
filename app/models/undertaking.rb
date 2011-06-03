# == Schema Information
# Schema version: 20110602015344
#
# Table name: undertakings
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  description   :text(255)
#  status_id     :integer
#  success_if    :text(255)
#  visibility_id :integer
#  access_code   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  scope_mask    :integer
#  metric_id     :integer
#

class Undertaking < ActiveRecord::Base
  attr_accessible :title, :description, :success_if, :access_code

  validates :title,      	:presence 	=> true,
                                :length   	=> { :within => 6..25 }
  validates :description,      	:presence 	=> true,
                                :length   	=> { :within => 6..255 }

  has_many :invitations
  has_many :relationships, :foreign_key => "contributor_id",
                           :dependent => :destroy
  has_many :contributing, :through => :relationships, :source => :contributed
  has_many :reverse_relationships, :foreign_key => "contributed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :contributors, :through => :reverse_relationships, :source => :contributor

  belongs_to :user 
  

  def contributing?(contributed)
   relationships.find_by_contributed_id(contributed)
  end

  def contribute!(contributed)
   relationships.create!(:contributed_id => contributed.id)
  end

  def withhold!(contributed)
    relationships.find_by_contributed_id(contributed).destroy
  end
end

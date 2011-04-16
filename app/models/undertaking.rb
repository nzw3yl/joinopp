# == Schema Information
# Schema version: 20110415005805
#
# Table name: undertakings
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  description   :string(255)
#  status_id     :integer
#  success_if    :string(255)
#  visibility_id :integer
#  access_code   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Undertaking < ActiveRecord::Base
  attr_accessible :title, :description, :success_if

  validates :title,      	:presence 	=> true,
                                :length   	=> { :within => 6..140 }
  validates :description,      	:presence 	=> true,
                                :length   	=> { :within => 6..255 }

  has_many :commitments, :dependent => :destroy
  has_many :users, :through => :commitments

  
end

# == Schema Information
# Schema version: 20110417012009
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
#

class Undertaking < ActiveRecord::Base
  attr_accessible :title, :description, :success_if, :access_code

  validates :title,      	:presence 	=> true,
                                :length   	=> { :within => 6..140 }
  validates :description,      	:presence 	=> true,
                                :length   	=> { :within => 6..255 }

  has_many :commitments, :dependent => :destroy
  has_many :users, :through => :commitments
  has_many :invitations

   
end

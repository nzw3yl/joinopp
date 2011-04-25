# == Schema Information
# Schema version: 20110419004522
#
# Table name: invitations
#
#  id             :integer         not null, primary key
#  email          :string(255)
#  access_code    :string(255)
#  expiry         :datetime
#  undertaking_id :integer
#  invitee_id     :integer
#  inviter_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Invitation < ActiveRecord::Base
  attr_accessible :invitee_id, :undertaking_id, :email, :access_code

  belongs_to :invitee, :class_name => "User"
  belongs_to :inviter, :class_name => "User"
  belongs_to :undertaking

  validates :inviter_id,	:presence => true
end

# == Schema Information
# Schema version: 20110415013435
#
# Table name: commitments
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  undertaking_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Commitment < ActiveRecord::Base
   attr_accessible :undertaking_id

   belongs_to :user
   belongs_to :undertaking

   validates :user_id,		:presence => true
   validates :undertaking_id,	:presence => true


 
end

# == Schema Information
# Schema version: 20110418004254
#
# Table name: commitments
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  undertaking_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#  roles_mask     :integer
#  role           :string(255)
#

class Commitment < ActiveRecord::Base
   attr_accessible :undertaking_id, :role_id

   belongs_to :user
   belongs_to :undertaking

   validates :user_id,		:presence => true
   validates :undertaking_id,	:presence => true

   scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "}}

   ROLES = %w[owner inviter member viewer]

   def roles=(roles)
     self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
   end

   def roles
     ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
   end 

   def role_symbols
     roles.map(&:to_sym)
   end

end

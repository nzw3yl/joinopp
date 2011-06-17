# == Schema Information
# Schema version: 20110617011958
#
# Table name: goals
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  user_id     :integer
#  scope_mask  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Goal < ActiveRecord::Base
   attr_accessible :user_id, :description, :title

   belongs_to :user
   has_many   :undertakings

   validates :title, :presence => true, :length => { :maximum => 50 }
   validates :user_id, :presence => true
   validates :description, :presence => true

   ORBITS = %w[personal family relationships friends career community]

   scope :with_orbit, lambda { |orbit| {:conditions => "scope_mask & #{2**ORBITS.index(orbit.to_s)} > 0"}} 
    

   def orbits=(orbits)
     self.scope_mask = (orbits & ORBITS).map { |s| 2**ORBITS.index(s) }.sum
   end

   def orbits 
     ORBITS.reject { |s| ((scope_mask || 0) & 2**ORBITS.index(s)).zero? }
   end

   def orbit_symbols
     orbits.map(&:to_sym)
   end

end

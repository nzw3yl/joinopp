# == Schema Information
# Schema version: 20110417232923
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  welcome_code       :string(255)
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#


require 'digest'

class User < ActiveRecord::Base
   attr_accessor :password
   attr_accessible :name, :welcome_code, :email, :password, :password_confirmation, :user_id

   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

   validates :name,      	:presence 	=> true,
                                :length   	=> { :maximum => 50 }
   validates :welcome_code,     :presence 	=> true,
                                :length   	=> { :maximum => 50 }
   validates :email,            :presence 	=> true,
                                :format   	=> { :with => email_regex },
                                :uniqueness 	=> { :case_sensitive => false }

   validates :password,		:presence	=> true,
				:confirmation	=> true,
				:length		=> { :within => 6..40 }

   has_many :reverse_invitations, :foreign_key => "invitee_id", :class_name => "Invitation", :dependent => :destroy
   has_many :inviters, :through => :reverse_invitations

   has_many :invitations,  :foreign_key => "inviter_id", :dependent => :destroy
   has_many :invitees, :through => :invitations

   has_many :undertakings
   has_many :goals

   before_save  :encrypt_password
  # before_create :new_invitee?

   def has_password?(submitted_password)
     encrypted_password == encrypt(submitted_password)
   end

   def self.authenticate(email, submitted_password)
     user = find_by_email(email)
     return nil if user.nil?
     return user if user.has_password?(submitted_password)
   end

   def self.authenticate_with_salt(id, cookie_salt)
     user = find_by_id(id)
     (user && user.salt == cookie_salt) ? user : nil
   end


   def inviter?(invitee, undertaking)
     @invitation = self.invitations.find_by_invitee_id_and_undertaking_id(invitee.id, undertaking.id)
   end

   def new_invitee?
     @invitation = Invitation.find(:first, :conditions => 
                       ["email = ? AND access_code = ?", self.email.downcase, self.welcome_code])
     !@invitation.nil? 
   end

   def invite!(invitee, undertaking)
     invitations.create!(:invitee_id => invitee.id, :undertaking_id => undertaking.id)
     #undertaking.invitations.create!(:invitee_id => invitee.id)
   end
   
   def uninvite!(invitee, undertaking) 
     #undertaking.invitations.find_by_invitee_id_and_inviter_id(invitee, self.id).destroy
     @invitation = self.invitations.find_by_invitee_id_and_undertaking_id(invitee.id, undertaking.id).destroy
   end
   

   private

     def encrypt_password
       self.salt = make_salt if new_record?
       self.encrypted_password = encrypt(password)
     end

     def encrypt(string)
       secure_hash("#{salt}--#{string}")
     end

     def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
     end

     def secure_hash(string)
       Digest::SHA2.hexdigest(string)
     end

     
end

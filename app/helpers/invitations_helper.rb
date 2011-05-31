module InvitationsHelper

  def invitations
   @invitations = current_user.invitations.find(:all)
  end

  def reverse_invitations(display_count = 4)
   @reverse_invitations = current_user.reverse_invitations.find(:all, :limit => display_count)
  end

  def undertaking_name(invitation)
    @undertaking_name = Undertaking.find(invitation.undertaking_id).title
  end

  def repeated_invitations(invitation, invitee)
    Invitation.count(:conditions => ["undertaking_id = ? AND invitee_id = ?", invitation.undertaking_id, invitee.id]) - 1
  end

  def link_invitations(user)
    user_invites = Invitation.where(:email => user.email)
    user_invites.each do |invite|
      invite.invitee_id = user.id
    end
  end

  def purge_user_invite(user)
     user_invites = Invitation.where(:invitee_id => user.id)
     user_invites.each do |invite|
      invite.destroy unless user.undertakings.find_by_id(invite.undertaking_id).nil?
     end
  end

  
end

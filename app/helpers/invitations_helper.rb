module InvitationsHelper

  def invitations
   @invitations = current_user.invitations.find(:all, :limit => 10)
  end

  def reverse_invitations
   @reverse_invitations = current_user.reverse_invitations.find(:all, :limit => 10)
  end

  def undertaking_name(invitation)
    @undertaking_name = Undertaking.find(invitation.undertaking_id).title
  end

end

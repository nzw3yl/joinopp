class InvitationsController < ApplicationController
  before_filter :authenticate, :only => [:new, :show, :index]

  def new
    @title = "Invitations"
  end

  def index
    @title = "All Invitations"
    @invitations = Invitation.order("email").page(params[:page]).per(20)
    render :layout => "application"
  end

  def show
    @invitation = Invitation.find(params[:id])
    @title = "Invitation"
    render :layout => "application"
  end


end

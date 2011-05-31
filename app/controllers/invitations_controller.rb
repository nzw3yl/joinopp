class InvitationsController < ApplicationController
  before_filter :authenticate, :only => [:new, :show, :index]
  before_filter :has_undertaking, :only => :new

  def new
    @title = "Invitations"
    @invitation = Invitation.new
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

  def create
   @user = current_user
   @invitation = @user.invitations.build(params[:invitation])
   if @invitation.save!
     flash[:success] = "Invitation Created."
     redirect_to @invitation
   end
  end

  def has_undertaking
   redirect_to root_path unless current_undertaking?
  end


end

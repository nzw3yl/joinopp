class CommitmentsController < ApplicationController
  before_filter :authenticate
  before_filter :uncommittable_user, :only => :destroy

  
  def create
   @undertaking = Undertaking.find(params[:commitment][:undertaking_id])
   #@user = User.find(params[:commitment][:user_id])
   current_user.devote!(@undertaking)
   #@commitment = @user.commitments.build(params[:commitment])
   #@commitment.roles = ['member']
   #@commitment.save!
   redirect_to @undertaking
  end

  def destroy
   @undertaking = Commitment.find(params[:id]).undertaking
   current_user.abandon!(@undertaking)
   redirect_to @undertaking
  end

end

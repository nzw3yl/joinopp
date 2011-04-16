class CommitmentsController < ApplicationController
  before_filter :authenticate

  def create
   @undertaking = Undertaking.find(params[:commitment][:undertaking_id])
   current_user.devote!(@undertaking)
   redirect_to @undertaking
  end

  def destroy
   @undertaking = Commitment.find(params[:id]).undertaking
   current_user.abandon!(@undertaking)
   redirect_to @undertaking
  end

end

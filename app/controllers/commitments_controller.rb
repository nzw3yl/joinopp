class CommitmentsController < ApplicationController
  before_filter :authenticate
  before_filter :uncommittable_user, :only => :destroy

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

  private
    
    def uncommittable_user
      @undertaking = Commitment.find(params[:id]).undertaking
      Commitment.find_by_undertaking_id_and_user_id(@undertaking, current_user).roles.include?("owner") || correct_user
    end

end

class CommitmentsController < ApplicationController
  before_filter :authenticate

  def create
  end

  def destroy
   Commitment.find(params[:id]).destroy
  end

end

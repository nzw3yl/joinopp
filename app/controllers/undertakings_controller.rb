class UndertakingsController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "Undertaking"
    @undertaking = Undertaking.new
  end

  def create
    @undertaking = current_user.undertakings.build(params[:undertaking])
    if @undertaking.save && set_undertaking(@undertaking)
     flash[:success] = "Undertaking created!"
     redirect_to @undertaking
    else
     render :new
    end
  end

  def show
   @undertaking = Undertaking.find(params[:id])
   @title = @undertaking.title 
  end

  private

	def authenticate 
	  deny_access unless signed_in?
        end

end

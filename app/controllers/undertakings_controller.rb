class UndertakingsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => :admin_index
  
  def new
    @title = "Undertaking"
    @undertaking = Undertaking.new
  end

  def create
    @undertaking = current_user.undertakings.build(params[:undertaking])
    if @undertaking.save && last_undertaking(@undertaking)
     current_user.devote!(@undertaking)  # why??
     flash[:success] = "Undertaking created!"
     redirect_to @undertaking
    else
     render :new
    end
  end

  def show
   @undertaking = Undertaking.find(params[:id])
   @title = @undertaking.title 
   last_undertaking(@undertaking)
  end


  def index
    @title = "All Undertakings"
    @undertakings = current_user.undertakings.order("title").page(params[:page]).per(20)
  end

  def admin_index
    @title = "Admin Index"
    @undertakings = Undertaking.order("title").page(params[:page]).per(20)
    render :index
  end


end

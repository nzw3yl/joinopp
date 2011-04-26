class UndertakingsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => [:admin_index, :destroy]
  
  def new
    @title = "Undertaking"
    @undertaking = Undertaking.new
  end

  def create
    @undertaking = current_user.undertakings.create(params[:undertaking])
    if @undertaking.save && last_undertaking(@undertaking) 
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

  def edit
   @undertaking = Undertaking.find(params[:id])
   @title = @undertaking.title 
  end

  def update
    @undertaking = Undertaking.find(params[:id])
    if @undertaking.update_attributes(params[:undertaking])
       flash[:success] = "Undertaking updated."
       redirect_to @undertaking
    else
       @title = "Edit Undertaking"
       render 'edit'
    end
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

  def destroy
    Undertaking.find(params[:id]).destroy
    flash[:success] = "Undertaking destroyed."
    redirect_to undertakings_path
  end


end

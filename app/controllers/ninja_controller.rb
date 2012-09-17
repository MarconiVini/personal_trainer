class NinjaController < ApplicationController
  layout "masters/login"
  def index
    @are_you_there_chelsea = params[:ninja]
  end
  
  def skill
    @ninja = params[:ninja]
    @ninpoo = params[:skill]
  end
  
  def new
    @new = "new action"
  end
    
  
end

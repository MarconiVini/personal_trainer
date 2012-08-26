class Administrador::PersonalsController < ApplicationController
  before_filter :require_authen                                                                           #Todos as requisições http nesse controle necessita authenticação
  before_filter :require_authorization_for_admin_creation                                                 #Requer nivel de autorizacao de administrador
  #Ambos os before_filters estão disponiveis no application_controller (visivel em todos os controles do aplicativo)  
  layout "masters/administrador"
  
  
  def index
    @personals = Personal.all 
  end
  
  def new
    @personal = Personal.new
  end
  
  def create
    @personal = Personal.new(params[:personal])    
    if @personal.save
      flash[:notice] = "O Personal \"#{@personal.name}\" foi criado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  def edit
    @personal = Personal.find(params[:id])
  end
  
  def update
    @personal = Personal.find(params[:id])
    if @personal.update_attributes(params[:personal])
      flash[:notice] = "O Personal Trainer \"#{@personal.name}\" foi editado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    personal = Personal.find(params[:id])
    personal.destroy
    flash[:notice] = "O Personal Trainer \"#{personal.name}\" foi deletado com sucesso !"
    redirect_to :action => :index
  end
  
end

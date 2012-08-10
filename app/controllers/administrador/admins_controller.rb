class Administrador::AdminsController < ApplicationController
  before_filter :require_authen                                             #Todos as requisições http nesse controle necessita authenticação
  before_filter :require_authorization, :only => [:destroy, :create, :update]
  layout "masters/administrador", except: ['login']
  #layout "masters/log_out", only: ['login']
  def index
    @admin = Admin.all
  end

  def new
    @admin = Admin.new
    @admin_level = Admin.admin_levels
  end

  def create
    @admin_level = Admin.admin_levels
    @admin = Admin.new(params[:admin])    
    if @admin.save
      flash[:notice] = "O Admin \"#{@admin.name}\" foi criado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :new, admin_level: @admin_level
    end
  end

  def show
    
  end

  def edit
    @admin = Admin.find(params[:id])
    @admin_level = Admin.admin_levels
  end

  def update
    @admin = Admin.find(params[:id])
    @admin_level = Admin.admin_levels
    if @admin.update_attributes(params[:admin])
      flash[:notice] = "O Admin \"#{@admin.name}\" foi editado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :edit, admin_level: @admin_level
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "O Admin \"#{@admin.name}\" foi deletado !"
    redirect_to :action => :index
  end
  
  def login
    render :layout => "masters/login"
  end
  
  private
  
  def require_authen
     #Verifica se a sessão já dura mais que 10 minutos, em caso positivo ele destroi a sessao fazendo logoff.
     if session[:last_seen] < 10.minutes.ago
       redirect_to "/administrador/destroy"
     end
     
     #Se a sessão ainda não expirou eu atualizo o tempo da sessão para a hora exata dando novamente 10 minutos para trabalhar logado.
     session[:last_seen] = Time.now
     
     #Recupera o admin baseado na sessão. Caso não haja administrador na sessão ele redireciona para a tela de login.
     if session[:admin_id]
       @admin_auth = Admin.find(session[:admin_id])
     else
       flash[:notice] = "Deslogado com sucesso !"
       redirect_to "/administrador"
     end
  end
  
  def require_authorization
    admin = Admin.find(session[:admin_id])
    if admin.admin_level.to_s != "1"
      flash[:error] = "O Administrador #{admin.name} nao tem autorizacao para deletar ou criar novos Administradores"
      redirect_to "/administrador/admins"
    end    
  end
  
end


class Administrador::AdminSessionController < ApplicationController
  layout "masters/login"
  def new

  end

  def create
    #Procuro o Admin baseado no email
    @admin = Admin.find_by_email(params[:login])
    
    #Testo o Admin encontrado a cima e faço a authenticação deste Admin baseado na senha.
    #Caso o Admin exista ele cria uma sesão com o ID do Admin e armazena o tempo de expiração da sessão redirecionando o Admin para o interior da intranet.
    if @admin && @admin.authenticate(params[:senha])
      session[:admin_id] = @admin.id
      session[:last_seen] = Time.now
      flash[:notice] = "Bem vindo \"#{@admin.name}\" !"
      redirect_to "/administrador/admins"
    else
      #No caso de não existir Administrador ele redireciona novamente para a tela de Login e dá um flash de erro.
      flash[:error] = "Login ou senha incorreto !"
      redirect_to "/administrador"
    end
  end

  def destroy
    #Reseta todas as configurações de sessão mostrando uma mensagem e redireciona para o form de login do Admin.
    session[:admin_id] = nil
    #session[:last_seen] = nil
    flash[:notice] = "Deslogado com sucesso !"
    redirect_to "/administrador"
  end

end

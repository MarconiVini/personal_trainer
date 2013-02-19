class Administrador::PersonalsController < ApplicationController
  before_filter :require_authen                                                                           #Todos as requisições http nesse controle necessita authenticação
  before_filter :require_authorization_admin_personals                                                    #Requer nivel de autorizacao de administrador
  #Ambos os before_filters estão disponiveis no application_controller (visivel em todos os controles do aplicativo)  
  layout "masters/administrador"
  
  
  def index
    @personals = Personal.all 
  end
  
  def new
    @personal = Personal.new
    get_autorizacao_apelidos                                                
  end
  
  def create
    @personal = Personal.new(params[:personal])
    @personal.admin_id = session[:admin_id]
    @personal.password = @personal.email
    @personal.password_confirmation = @personal.email
    if @personal.url.empty?                                                   #Se o url é nulo, caso seja ele mostra as dicas, caso contrario ele tenta salvar
      url_ou_dicas = @personal.testa_url_ou_return_sugestao
      if url_ou_dicas.class == String                                         #Caso seja String significa que que retornou apenas o nome do Personal
        @personal.url = url_ou_dicas
        if @personal.save
          flash[:notice] = "O Personal \"#{@personal.name}\" foi criado com sucesso !"
          redirect_to :action => :index
        else
          @personal.url = url_ou_dicas
          get_autorizacao_apelidos
          render :action => :new
        end
      else                                                                    #Caso entre no else então o tipo é um Array com as dicas dos nomes
        flash[:notice] = "Ja existe uma URL registrada para o primeiro nome do personal: #{@personal.name}, por favor escolha uma entre as dicas de URL abaixo."
        @links_sugestao = url_ou_dicas
        get_autorizacao_apelidos
        render :action => :new
      end
    else                                                                      #Se o url nao for nulo ele verifica se o url já existe, caso exista ele mostra as dicas, caso contrario ele tenta salvar
      if @personal.save
        flash[:notice] = "O Personal \"#{@personal.name}\" foi criado com sucesso !"
        redirect_to :action => :index
      else
        flash[:notice] = "Este email ja existe."
        get_autorizacao_apelidos
        render :action => :new
      end
    end
  end
  
  def edit
    @personal = Personal.find(params[:id])
    get_autorizacao_apelidos
  end
  
  def update
    @personals = Personal.all
    #ignore
    
    @personal = Personal.find(params[:id])                                    #Busca o personal normal do update
    url_test = Personal.find_by_url(params[:personal][:url])                  #Busca um personal baseado no novo url
    if url_test.nil?
      if @personal.update_attributes(params[:personal])
        flash[:notice] = "O Personal \"#{@personal.name}\" foi atualizado com sucesso !"
        redirect_to :action => :index
      else
        flash[:notice] = "Ocorreu algum erro tente na atualizacao do Personal: #{@personal.name}"
        render :action => :edit
      end
    else
      if url_test.id == @personal.id
        if @personal.update_attributes(params[:personal])
          flash[:notice] = "O Personal \"#{@personal.name}\" foi atualizado com sucesso !"
          redirect_to :action => :index
        else
          flash[:notice] = "Ocorreu algum erro tente na atualizacao do Personal: #{@personal.name}"
          render :action => :edit
        end
      else
        flash[:notice] = "O personal #{url_test.name} ja esta usando o url #{url_test.name}, usar um outro url."
        get_autorizacao_apelidos
        render :action => :edit
      end
    end
  end
  
  def destroy
    personal = Personal.find(params[:id])
    personal.destroy
    flash[:notice] = "O Personal Trainer \"#{personal.name}\" foi deletado permanetemente!"
    redirect_to :action => :index
  end
  
  def reativar
    personal = Personal.find(params[:id])
    personal.set_to_active
    personal.save
    flash[:notice] = "O Personal Trainer \"#{personal.name}\" foi re-ativado com sucesso!"
    redirect_to :action => :index
  end
  
  def desativar
    personal = Personal.find(params[:id])
    personal.set_to_inactive
    personal.save
    #personal.destroy
    flash[:notice] = "O Personal Trainer \"#{personal.name}\" foi inativado com sucesso!"
    redirect_to :action => :index
  end
  
  private
  
  def get_autorizacao_apelidos
    sessao = session[:admin_id].to_s
    @autorizacao = Admin.find(sessao).admin_level.to_s
  end
  
end

class Site::UserSessionsController < ApplicationController
  layout "masters/login"
  def create
    #Verifica se o tipo de usuário é um Personal ou Aluno
    categoria = params[:radio][:category]
    if categoria == "Personal"
      @check = "categoria personal"
      @personal = Personal.find_by_email(params[:login])
      if @personal && @personal.authenticate(params[:senha])
        session[:personal_id] = @personal.id
        session[:last_seen_personal] = Time.now
        redirect_to "/on/#{@personal.url}"
      end
      @mensage = 'User nao autenticado'
    else
      @check = "categoria Aluno"
    end
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def require_authen_personal
    if session[:last_seen_personal] && session[:last_seen_personal] < 30.seconds.ago
      #Verifica se a sessão já dura mais que 30 minutos, em caso positivo ele destroi a sessao fazendo logoff e redirecionando para a página deslogada.
      session[:personal_id] = nil
      session[:last_seen_personal] = nil
      redirect_to "/#{params[:personal]}"
    else
      #Caso não seja redirecionado atualiza o timer do lest_seen
      session[:last_seen_personal] = Time.now   
    end
    
  end

  def require_authen

    #Verifica se a sessão já dura mais que 10 minutos, em caso positivo ele destroi a sessao fazendo logoff.
    if session[:last_seen] != nil
      if session[:last_seen] < 30.minutes.ago
        redirect_to "/administrador/destroy"
      end
    end

    #Recupera o admin baseado na sessão. Caso não haja administrador na sessão ele redireciona para a tela de login.
    if session[:admin_id]
      #Se a sessão ainda não expirou eu atualizo o tempo da sessão para a hora exata dando novamente 10 minutos para trabalhar logado.
      session[:last_seen] = Time.now
      @admin_auth = Admin.find(session[:admin_id])
    else
      flash[:notice] = "Deslogado com sucesso !"
      redirect_to "/administrador"
    end
  end

  def require_authorization_admin_superior
    admin = Admin.find(session[:admin_id])
    if admin.authorization_test(1) == false
      flash[:error] = "O Administrador #{admin.name} nao tem autorizacao para deletar ou criar novos Administradores"
      redirect_to "/administrador/admins"
    end
  end

  def require_authorization_admin_dados
    admin = Admin.find(session[:admin_id])
    if admin.authorization_test(3) == false
      flash[:error] = "O Administrador #{admin.name} nao tem autorizacao para deletar ou criar novos Administradores"
      redirect_to "/administrador/admins"
    end
  end

  def require_authorization_admin_personals
    admin = Admin.find(session[:admin_id])
    if admin.authorization_test(2) == false
      flash[:error] = "O Administrador #{admin.name} nao tem autorizacao para deletar ou criar novos Administradores"
      redirect_to "/administrador/admins"
    end
  end
end

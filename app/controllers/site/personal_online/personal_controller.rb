class Site::PersonalOnline::PersonalController < ApplicationController
  layout "masters/site"
  before_filter :require_authen_personal                    #verifica se a página ficou ativa no ultimos 30 min caso contrario desloga o personal e redireciona para sua versao offline
  #O :require_authen_personal fica no application_controller.rb
  
  def index
    @personal = Personal.first(:conditions => {id: session[:personal_id], active: true})
  end
  
  def contato
    
  end
  
  
  def logoff
    session[:personal_id] = nil
    redirect_to "/#{params[:personal]}"
  end
  
    
  
end

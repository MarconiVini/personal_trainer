class Site::PersonalOffline::PersonalController < ApplicationController
  layout "masters/site"
  
  
  def index
    personal_url = params[:personal]
    @personal = Personal.first(:conditions => {url: personal_url, active: true})
  end
  
end

class Administrador::AdminsController < ApplicationController
  def index
    @admin = Admin.all
  end

  def new
    @admin = Admin.new
    @admin_level = Admin.admin_levels
  end

  def create
    @admin = Admin.create!(params[:admin])
    flash[:notice] = "O Admin #{@admin.name} foi criado com sucesso !"
    redirect_to :action => :index

  end

  def show

  end

  def edit

  end

  def destroy

  end

end
